.PHONY: all clean

all:
	swift build
	./.build/debug/enzo parse contentfulcda

clean:
	swift build --clean
