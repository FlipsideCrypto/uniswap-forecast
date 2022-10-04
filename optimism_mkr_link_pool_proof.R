# Made a fake pool on Optimism 
# 
# LINK/MKR 0.3% Pool 
# Optimism Contract: 0x353ec75f40edb3b794e10bc049532e60d89d5d19
# Liquidity: 
#   343255264548669212  <- TOTAL Liquidity in Pool
# 
# feeGrowthGlobal0X128: 0
# feeGrowthGlobal1X128: 0
# maxLiquidityPerTick: 11505743598341114571880798222544994
# 
# MKR/LINK <- ONLY position in pool 
# min Tick: -50100 => 0.006672574
# max tick: -39120 => 0.02000437
# Current Price
# 0.0092645 MKR/LINK
# 
# Token0 // 18 decimals OPTIMISM
# Chainlink: 0x350a791bfc2c21f9ed5d10980dad2e2638ffa7f6 
# 
# Token1: // 18 decimals OPTIMISM 
# Maker: 0xab7bAdEF82E9Fe11f6f33f87BC9bC2AA27F2fCB5
# 
# Balance: 
#   1.13928923 LINK
# 0.005 MKR
# 
# 1.13928923 * 1e18
# 
# 0.005 * 1e18
# 5000000000000000

y = as.bigq(1.139289230675491064)*1e18 # decimal adjustment
x = as.bigq(0.005)*1e18  # decimal adjustment
P = 0.009264495
min_tick <- -50100
max_tick <- -39120
pa = 0.006672574
pb = 0.02000437

sqrtpX96 =  as.bigz('7625888651129286871474510862')
tick = -46818

tick_to_price(tick, decimal_adjustment = 1, yx = FALSE)

library(gmp)
L = as.bigz("343255264548669212") # actual liquidity from contract  


get_liquidity_y <- function(y, P, pb){ 
  f1 = as.bigq(sqrt(P)) * as.bigq(sqrt(pb))
  f2 = as.bigq(sqrt(pb)) - as.bigq(sqrt(P))
  
  L = y * f1 / f2
  
  return( as.bigz(L) )
}

get_liquidity_y(y, P, pb)

get_liquidity_x <- function(x, P, pa){ 
  f1 = as.bigq(sqrt(P)) - as.bigq(sqrt(pa))
  
  L = x / f1
  
  return( as.bigz(L) )
  
  }

get_liquidity_x(x, P, pa)
