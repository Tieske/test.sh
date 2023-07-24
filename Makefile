# only 1 target for linting

lint:
	bash -c 'shopt -s globstar nullglob &> /dev/null; shellcheck **/*.{sh,ksh,bash}'
