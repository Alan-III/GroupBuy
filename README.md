# GroupBuy

## Basic Developer Guidelines

**Use meaningful variable names:**

// Bad
let a = 10;
let x = "John";

// Good
let age = 10;
let name = "John";

**Provide descriptive function names:**

// Bad
function calculate() {
  // ...
}

// Good
function calculateTotalPrice() {
  // ...
}

**Use clear and consistent naming conventions for classes:**

// Bad
class user {
  // ...
}

// Good
class User {
  // ...
}

**Differentiate between similar names with prefixes or suffixes:**

// Bad
let customerName = "John";
let customerAddress = "123 Main St";

// Good
let customerName = "John";
let customerAddressStreet = "123 Main St";

**Avoid single-letter variable names or abbreviations that can be ambiguous:**

// Bad
let a = 5;
let info = getUserInfo();

// Good
let age = 5;
let userInfo = getUserInformation();

**Use consistent and meaningful naming for function parameters:**

// Bad
function calculate(x, y) {
  // ...
}

// Good
function calculateTotalPrice(price, quantity) {
  // ...
}

**Ensure clarity when using boolean variables:**

// Bad
let t = true;

// Good
let isActive = true;