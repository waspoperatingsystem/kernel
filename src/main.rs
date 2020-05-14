/*	$waspOS: main.rs,v 1.0 2020/05/14 00:00:00 protonesso Exp $	*/

// Inspired by this https://os.phil-opp.com/freestanding-rust-binary/
#![no_std]
#![no_main]

use core::panic::PanicInfo;

mod vga;

#[no_mangle]
pub extern "C" fn _start() -> ! {
	vga::welcome();
	
	loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
	loop {}
}
