library(dplyr)
library(shroomDK)

lp_actions <- auto_paginate_query(
  query = "
  SELECT * FROM ethereum.uniswapv3.ez_lp_actions
                    WHERE POOL_ADDRESS = '0xcbcdf9626bc03e24f779434178a73a0b4bad62ed' AND 
                    BLOCK_NUMBER <= 15576600
                    ORDER BY BLOCK_NUMBER DESC
  ",
  api_key = readLines("api_key.txt")
)

lpas <- lp_actions %>% select(BLOCK_NUMBER, TX_HASH, LIQUIDITY_PROVIDER, NF_POSITION_MANAGER_ADDRESS,
                              NF_TOKEN_ID, ACTION, AMOUNT0_ADJUSTED, AMOUNT1_ADJUSTED, 
                                    TOKEN0_SYMBOL, TOKEN1_SYMBOL, LIQUIDITY, LIQUIDITY_ADJUSTED,TICK_LOWER, TICK_UPPER)

lp_actions_no_id <- lpas %>% filter(is.na(NF_TOKEN_ID))
lp_actions_liquidity_trace_missing <- lpas %>% filter(is.na(LIQUIDITY))

lp1 <- lpas %>% filter(
    !is.na(NF_TOKEN_ID) & !is.na(NF_POSITION_MANAGER_ADDRESS) & !is.na(LIQUIDITY_ADJUSTED)
)

lps <- lp1 %>% group_by(NF_TOKEN_ID) %>% mutate(
  liq_sign = ifelse(ACTION == 'DECREASE_LIQUIDITY', -1*LIQUIDITY_ADJUSTED, LIQUIDITY_ADJUSTED)
) %>% summarize(sumliq = sum(liq_sign))

lp_problem <- lps %>% filter(sumliq < -0.0001)

lp_actions_problem_ids <- lpas %>% filter(NF_TOKEN_ID %in% lp_problem$NF_TOKEN_ID)

# Liquidity WORKS 

l244 <- (lpas %>% arrange(NF_TOKEN_ID, LIQUIDITY_PROVIDER, BLOCK_NUMBER) %>% filter(NF_TOKEN_ID == '244'))
l244 <- l244 %>% mutate(
  liq_sign = ifelse(ACTION == 'DECREASE_LIQUIDITY', -1*LIQUIDITY, LIQUIDITY))
sum(l244$liq_sign)

# Liquidity does NOT Work
l90604 <- (lpas %>% arrange(NF_TOKEN_ID, LIQUIDITY_PROVIDER, BLOCK_NUMBER) %>% filter(NF_TOKEN_ID == '90604'))
l90604 <- l90604 %>% mutate(
  liq_sign = ifelse(ACTION == 'DECREASE_LIQUIDITY', -1*LIQUIDITY, LIQUIDITY))
sum(l90604$liq_sign)

# these liquidity should be 0; but collect & remove liq in same tx duplicates liquidity
trouble_tx <- lp_actions %>% filter(LIQUIDITY > 0 & AMOUNT0_ADJUSTED == 0 & AMOUNT1_ADJUSTED == 0)

View(lp_actions %>% filter(TX_HASH %in% trouble_tx$TX_HASH))
