REM setting the heap size to ~ 10 GB 
set NODE_OPTIONS="--max_old_space_size=10240"

if exist "..\client-fccui\node_modules\" (
  echo node_modules exist 
) else (
	if exist "..\client-fccui\fccui-0.0.0.tgz" (
	  echo fccui-0.0.0.tgz exist 
	) else (
	  copy "..\warcontent\content\fccui-lib\fccui-0.0.0.tgz" "..\client-fccui"
	)
	pushd "..\client-fccui"
	call npm install
	popd
)