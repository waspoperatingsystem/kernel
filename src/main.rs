/*	$waspOS: main.rs,v 1.0 2020/07/06 00:00:00 protonesso Exp $	*/

// Inspired by this https://os.phil-opp.com/freestanding-rust-binary/
#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[cfg(target_arch = "sparc64")]
mod sparcboot;


#[cfg(target_arch = "powerpc64le")]
mod ppcboot;

mod vga;

#[no_mangle]
pub extern "C" fn kmain() -> ! {
	vga::welcome();
	
	loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
	loop {}
}
