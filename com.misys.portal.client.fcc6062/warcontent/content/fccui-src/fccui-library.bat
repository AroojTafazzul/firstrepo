REM setting the heap size to ~ 10 GB 
set NODE_OPTIONS=--max_old_space_size=18000
call npm run packagr
cd dist/fccui-lib
call npm pack
