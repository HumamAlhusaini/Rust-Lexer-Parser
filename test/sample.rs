fn hello_world(name: &str) {
    print!("Hello {}", name);
}

struct Person {
    name: &'static str, // use a string literal
}

fn main() {
    let sam = Person {
        name: "Sam", // string literal
    };

    hello_world(sam.name);
}

