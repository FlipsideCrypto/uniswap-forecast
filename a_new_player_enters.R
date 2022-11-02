# Real World random Trade 

#' A random person was trading MKR to LINK and it was routed to the test pool
#' It shows something interesting: if there is not change in what ranges are active
#' Then trades across ticks only minimally change liquidity and can act as if in the same tick? 

# https://optimistic.etherscan.io/tx/0xec76dec1d664f4d0126513bd4ba59c3fe933086a914ac285c2b7dd038477e0de

# Pool prior to trade 
l1 = '343255263830421644'
p1 = '7609891887904192334730581214'
tick1 = -46860
x1 = as.bigq(1.146808312350982128) #LINK (18 decimals)
y1 = as.bigq(0.00493069417466594) #MKR (18 decimals)

# result of random person who intersected the proxy pool
y_diff = as.bigq(0.004036007711868033) 
x_diff = 0.5

# final balance of proxy pool 
y2 = as.bigq(0.000894686462797907) # MKR
x2 = as.bigq(1.646808312350982128) # LINK

# final liquidity and price info 
l2 = '343255264548669212'
p2 = '6678324311438468291016353224'
tick2 = -49472

# shows actual change in LINK across prices 
size_price_change_in_tick(L = l2,
                          sqrtpx96 = p1,
                          sqrtpx96_target = p2, 
                          dx = TRUE)

# == 0.5

# shows actual change in MKR across prices 
size_price_change_in_tick(L = l2,
                          sqrtpx96 = p1,
                          sqrtpx96_target = p2, 
                          dx = FALSE)
# -0.004036008
