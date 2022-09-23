library(shroomDK)

pool_stats <- auto_paginate_query(
  query = "
  SELECT * FROM ethereum.uniswapv3.ez_pool_stats
                    WHERE POOL_ADDRESS = '0xcbcdf9626bc03e24f779434178a73a0b4bad62ed' AND 
                    BLOCK_NUMBER <= 15576600
                    ORDER BY BLOCK_NUMBER DESC
  ",
  api_key = readLines("api_key.txt")
)

lp_actions <- auto_paginate_query(
  query = "
  SELECT * FROM ethereum.uniswapv3.ez_lp_actions
                    WHERE POOL_ADDRESS = '0xcbcdf9626bc03e24f779434178a73a0b4bad62ed' AND 
                    BLOCK_NUMBER <= 15576600
                    ORDER BY BLOCK_NUMBER DESC
  ",
  api_key = readLines("api_key.txt")
)

fees <- auto_paginate_query(
  query = "
  SELECT * FROM     ethereum.uniswapv3.ez_position_collected_fees
                    WHERE POOL_ADDRESS = '0xcbcdf9626bc03e24f779434178a73a0b4bad62ed' AND 
                    BLOCK_NUMBER <= 15576600
                    ORDER BY BLOCK_NUMBER DESC
  ",
  api_key = readLines("api_key.txt")
)

positions <- auto_paginate_query(
  query = "
  SELECT * FROM     ethereum.uniswapv3.ez_positions
                    WHERE POOL_ADDRESS = '0xcbcdf9626bc03e24f779434178a73a0b4bad62ed' AND 
                    BLOCK_NUMBER <= 15576600
                    ORDER BY BLOCK_NUMBER DESC
  ",
  api_key = readLines("api_key.txt")
)

swaps <- auto_paginate_query(
  query = "
  SELECT * FROM     ethereum.uniswapv3.ez_swaps
                    WHERE POOL_ADDRESS = '0xcbcdf9626bc03e24f779434178a73a0b4bad62ed' AND 
                    BLOCK_NUMBER <= 15576600
                    ORDER BY BLOCK_NUMBER DESC
  ",
  api_key = readLines("api_key.txt")
)
