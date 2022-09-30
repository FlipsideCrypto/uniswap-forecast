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

x = 1.139289230675491064 * 1e18 # decimal adjustment
y = 0.004999 * 1e18 # decimal adjustment
P = 0.0092645
pa = 0.0066726
pb = 0.020004

L = as.bigz("343255264548669212") # actual liquidity 

L1 = x*(sqrt(P)*sqrt(pb))/( sqrt(pb) - sqrt(P)) # within 0.02% of L
L2 = y / ( sqrt(P)-sqrt(pa) )
L2
