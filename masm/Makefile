ML=ml64
LIB=lib
LINK=link
WIN64_LIBPATH=C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x64
_=$() $()
ROOT_TOKENS=$(subst /,$(_),$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
ROOT=$(firstword $(ROOT_TOKENS)):\$(subst $(_),\,$(wordlist 2,$(words $(ROOT_TOKENS)),$(ROOT_TOKENS)))

# Enable debug symbols
# DEBUG=1

ifeq ($(DEBUG),1)
	LINKFLAGS=/SUBSYSTEM:CONSOLE /DEBUG:FULL /LIBPATH:"$(WIN64_LIBPATH)" /LIBPATH:"$(ROOT)\utils"
else
	LINKFLAGS=/SUBSYSTEM:CONSOLE /LIBPATH:"$(WIN64_LIBPATH)" /LIBPATH:"$(ROOT)\utils"
endif

%.library:
	cd $(*D); \
	$(ML) //c $(*F).asm; \
	$(LIB) /out:$(*F).lib $(*F).obj

%.executable:
	cd $(*D); \
	$(ML) //c $(*F).asm; \
	$(LINK) $(*F).obj $(LINKFLAGS) /out:$(*F).exe /entry:main

hello_world: \
	utils/utils.library \
	hello_world/hello_world.executable

text2ascii: \
	utils/utils.library \
	text2ascii/text2ascii.executable

text2bin: \
	utils/utils.library \
	text2bin/text2bin.executable

text2hex: \
	utils/utils.library \
	text2hex/text2hex.executable

all: \
	hello_world \
	text2ascii \
	text2bin \
	text2hex
