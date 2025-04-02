fn main() {
    let x: i32 = 10;
    let y: i32 = 20;

    let result: i32 = x + y * 2;
    println!("Result: {}", result);

    if result == 30 {
        println!("Equal!");
    } else {
        println!("Not equal!");
    }

    let mut z: bool = true;

    while z {
        println!("Looping!");
        z = false;
    }

    let a: u8 = 0b1100;
    let b: u8 = 0b1010;
    let c: u8 = a & b;
    println!("Bitwise AND: {}", c);

    let address_of_x: &i32 = &x;
    println!("Address of x: {:?}", address_of_x);

    let mut mutable_y: i32 = 5;
    let mutable_ptr: &mut i32 = &mut mutable_y;
    *mutable_ptr = 15;
    println!("Mutable y now: {}", mutable_y);

    let s: &'static str = "Hello, Rust!";
    println!("{}", s);

    let bitwise_or = a | b;
    println!("Bitwise OR: {}", bitwise_or);

    let bitwise_xor = a ^ b;
    println!("Bitwise XOR: {}", bitwise_xor);

    let bitwise_not = !z;
    println!("Bitwise NOT: {}", bitwise_not);

    let left_shift = a << 2;
    println!("Left shift: {}", left_shift);

    let right_shift = b >> 1;
    println!("Right shift: {}", right_shift);

    let compound_assign = mutable_y += 5;
    println!("Compound assign: {}", compound_assign);

    let is_equal = result == 30;
    println!("Is equal: {}", is_equal);

    let not_equal = result != 25;
    println!("Not equal: {}", not_equal);

    let less_than = x < y;
    println!("Less than: {}", less_than);

    let greater_than = y > x;
    println!("Greater than: {}", greater_than);

    let less_than_or_equal = x <= 10;
    println!("Less than or equal: {}", less_than_or_equal);

    let greater_than_or_equal = y >= 20;
    println!("Greater than or equal: {}", greater_than_or_equal);

    let logical_and = true && false;
    println!("Logical AND: {}", logical_and);

    let logical_or = true || false;
    println!("Logical OR: {}", logical_or);

    // Single-line comment
    let period = 1.0;
    println!("{}", period);

    let struct_example = 1;
    println!("{}", struct_example);
}
