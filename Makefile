all:
	zig build-exe src/main.zig -femit-bin=planets
	./planets
