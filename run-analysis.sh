# replace the path with the path to bazel-compilation-database on your machine
# you can download it from https://github.com/grailbio/bazel-compilation-database/tags
~/codes/clone/bazel-compilation-database-0.4.5/generate.sh

# you should now have compile_commands.json under the current directory

# exclude the system headers from compilation commands, as they are in conflict with the builtin headers of the analyzer
sed -i 's@-I /usr/\S* @@g' compile_commands.json

# generate the configuration file for tis-analyzer from compile_commands.json
python3 ./gen-tis-config.py >tis.config

# you should now have tis.config under the current directory

# run the analysis
tis-analyzer++ -tis-config-load tis.config -tis-config-select 1 --interpreter -gui
# Output:
# [kernel] Loading configuration file tis.config (analysis #1)
# [kernel] Reading compilation database in compile_commands.json
# [kernel] Configuration successfully loaded.
# [kernel] [1/8] Parsing TIS_KERNEL_SHARE/libc/__fc_builtin_for_normalization.i (no preprocessing)
# [kernel] [2/8] Parsing TIS_KERNEL_SHARE/libcxx/runtime/libcxx_runtime.cpp (external front-end)
# [kernel] [3/8] Parsing TIS_KERNEL_SHARE/libcxx/runtime/__dynamic_cast.c (with preprocessing)
# [kernel] [4/8] Parsing TIS_KERNEL_SHARE/libc/tis_runtime.c (with preprocessing)
# [kernel] [5/8] Parsing TIS_KERNEL_SHARE/__tis_mkfs.c (with preprocessing)
# [kernel] [6/8] Parsing TIS_KERNEL_SHARE/mkfs_empty_filesystem.c (with preprocessing)
# [kernel] [7/8] Parsing main/main.cc (external front-end)
# [cxx] Now output intermediate result
# :1:[cxx] warning: unknown warning option '-Wunused-but-set-parameter'; did you mean '-Wunused-parameter'?
# [kernel] [8/8] Parsing lib/caesar.cc (external front-end)
# [cxx] Now output intermediate result
# :1:[cxx] warning: unknown warning option '-Wunused-but-set-parameter'; did you mean '-Wunused-parameter'?
# [kernel] Successfully parsed 2 files (+6 runtime files)
# [value] Analyzing a complete application starting at main
# [value] Computing initial state
# [value] Initial state computed
# [value] The Analysis can be stopped with: kill -USR1 3198876
# lib/caesar.cc:21:[kernel] warning: out of bounds write. assert \valid(buf+i);
#                   stack: caesar_encrypt :: main/main.cc:10 <-
#                          gen_test :: main/main.cc:26 <-
#                          main
# [value] Stopping at nth alarm
# [from] Non-terminating function caesar_encrypt (no dependencies)
# [from] Non-terminating function gen_test (no dependencies)
# [from] Non-terminating function main (no dependencies)
# [value] user error: Degeneration occurred:
#                     results are not correct for lines of code that can be reached from the degeneration point.
# 
# Ready 2021-08-19 19:21 port 8080
# 
# Note: See 'http://localhost:8080/doc/man/tis-gui/start.html#sec-proxy'
# to know how to quickly set up a reverse-proxy to access to the GUI
# through the network
# 
# [TrustInSoft Analyzer] You can launch the GUI with:
#      chromium-browser http://localhost:8080/
# 
