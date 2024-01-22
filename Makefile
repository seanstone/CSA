# brew install llvm libomp

CC = /opt/homebrew/opt/llvm/bin/clang
CXX = /opt/homebrew/opt/llvm/bin/clang++

CPPFLAGS += -Wall -pedantic -O3 -Iinclude
CPPFLAGS += -fopenmp=libomp -I/opt/homebrew/opt/libomp/include
LDFLAGS += -L/opt/homebrew/opt/libomp/lib

SRCS := example.cpp $(wildcard include/*.hpp include/*/*.hpp)

run_csa : $(SRCS)
	$(CXX) $(CPPFLAGS) $(LDFLAGS) example.cpp -o $@

.PHONY : docs
docs :
	mkdir -p ./docs/doc
	cd ./docs && doxygen Doxyfile

.PHONY : clean
clean :
	rm -f run_csa
	rm -rf run_csa.dSYM/
	rm -f ./include/*.gch
	cd ./docs && rm -rf doc/
