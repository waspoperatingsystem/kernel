/*	$waspOS: main.rs,v 1.0 2020/05/14 00:00:00 protonesso Exp $	*/

pub fn welcome() {
	static HELLO: &[u8] = b"Welcome to waspOS!";
	let vga_buf = 0xb8000 as *mut u8;

	for (i, &byte) in HELLO.iter().enumerate() {
		unsafe {
			*vga_buf.offset(i as isize * 2) = byte;
			*vga_buf.offset(i as isize * 2 + 1) = 0xf;
		}
	}
}
