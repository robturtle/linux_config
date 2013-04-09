#!/bin/bash

echo "enable_testing ()" >> CMakeLists.txt
echo "set (TARGET_LIST"  >> CMakeLists.txt
echo "\${TARGET_LIST}"   >> CMakeLists.txt
ls *.cpp *.cxx *.cc *.c | xargs egrep "main[ \t]*(.*)[ \t]*$" | cut -d ":" -f 1 >> CMakeLists.txt
echo ")"                 >> CMakeLists.txt
echo "foreach (SRC \${TARGET_LIST})" >> CMakeLists.txt
echo "  string (REGEX REPLACE \"[.]cpp\$\" \".ELF\" ELF \${SRC})" >> CMakeLists.txt
echo "  add_executable (\${ELF} \${SRC})" >> CMakeLists.txt
echo "  target_link_libraries (\${ELF} \${EXTRA_LIBS})" >> CMakeLists.txt
echo "  add_test (\${ELF}_Runs \${ELF})"  >> CMakeLists.txt
echo "endforeach (SRC)"                   >> CMakeLists.txt
