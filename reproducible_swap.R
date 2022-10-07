library(gmp)

# REAL SWAP
# https://optimistic.etherscan.io/tx/0x48bbeb4fd7e6f04950e24929314a4730a62528e6da1d61d378ad9599bf442fd6

# Pool LOST MKR and GAINED LINK
user_submitted <- 0.000000030675491064
delta_link     <- 0.000000030675491064
                  0.00000003067549
                  # 0.00000003058346
                  
delta_maker <- -0.000000000283340352

# Pool changed ticks but still within tick spacing
tick1 = -46818
tick2 = -46819

# Pool Liquidity did NOT change 
liq1 = as.bigz('343255264548669212')
liq2 = as.bigz('343255264548669212')

# Pool Price DID change 
sqrtpx96_1 = as.bigz('7625888651129286871474510862')
sqrtpx96_2 = as.bigz('7625888585730332125670982418')

dy = -0.000000000283340352
dx = 0.000000030675491064

deltaP <- sqrtpx96_2 - sqrtpx96_1
ideltaP <- sqrtpx96_2^-1 - sqrtpx96_1^-1

delta_x <- liq1 * ideltaP 
delta_y <- liq1 * deltaP

fix_y <- function(y, decimal_adjustment = 1e18){
  as.numeric( y / (as.bigz(2)^96) ) / decimal_adjustment
}
fix_x <- function(x, decimal_adjustment = 1e18, fee = 0.003){
 as.numeric(x * as.bigz(2^96))/1e18 / (1 - fee)
 
}

dxa * (1 - fee) * 1e18 / (as.bigz(2)^96)


delta_y_adjusted <- fix_y(y = delta_y)
delta_x_adjusted <- fix_x(x = delta_x)

delta_maker
delta_y_adjusted
delta_link
delta_x_adjusted


#-----

L = as.bigz('343255264548669212')
P = as.bigz('7625888651129286871474510862')
dx = 0.000000030675491064
dy = -0.000000000283340352
c96 = (as.bigz(2)^96)
iP = P^-1
decimal_x = 1e18
decimal_y = 1e18
fee = 0.003

swap_within_tick <- function(L, sqrtpx96, dx = NULL, dy = NULL, 
                             decimal_x = 1e18,
                             decimal_y = 1e18, 
                             fee = 0.003){
  # Change in price = Delta(Y) / L 
  # change in Inverse(Price) = Delta(X)/L
  
  # price in *square root* 64.96 form 
  L = as.bigz(L)
  P = as.bigz(sqrtpx96)
  c96 = (as.bigz(2)^96)
  # inverse price
  iP = P^-1
  
  # adjust real dx or dy to 96 int & adjust for fees
  if(!is.null(dx)){
  dxa <- as.bigq(dx) * (1 - fee) * decimal_x / (as.bigz(2)^96)
  }
  if(!is.null(dy)){
    dya <- as.bigq(dy) * c96 * decimal_y
  }
  
  r = list(
    liquidity = L,
    dx = NULL,
    dy = NULL,
    price1 = P,
    price2 = NULL
  )
  
  if(is.null(dx) & is.null(dy)){
    stop("A change in x or y is required to use liquidity")
  }
  
  if(!is.null(dx) & !is.null(dy)){
    stop("Only 1 swap can be noted")
  }
  
  if(!is.null(dx)){
  # iP_new - iP = dx/L
  # iP_new = dx/L + iP
  
  iP_new = dxa/L + iP
  P_new = iP_new^-1
  
  # dy = (P_new - P)*L
  dya = (P_new - P)*L
  
  # convert back to real units 
  dy = as.numeric( dya / c96 ) / decimal_y
  
  r$dx = dx
  r$dy = dy
  r$price2 <- as.bigz(P_new)
  }
  
  if(!is.null(dy)){
    # dy =  (P_new - P)*L
    # P_new = dy/L + P 
    
    P_new = dya/L + P 
    
    iP_new = P_new^-1
    
    dxa = (iP_new - iP)*L
    
    # convert to real units 
    dx = as.numeric(dxa * c96) / decimal_x
    
    r$dx <- dx
    r$dy <- dy
    r$price2 <- as.bigz(P_new)
  }
  
  return(r)
  
}


