let number = 2
const word = 'javascript'
console.log('number:', number)
console.log('number:', word)

// word = 'test' <- this will cause an error because `const` means this is a constant pointer

const exampleArray = []
console.log('exampleArray:', exampleArray)
exampleArray.push('This will work, because although the array itself is immutable, the data inside it is not.')
console.log('exampleArray:', exampleArray)

// variables are dynamically typed
let stringThenNum = 'is right now a string'
console.log('stringThenNum:', stringThenNum)
stringThenNum = 0
console.log('stringThenNum:', stringThenNum)

// lowercase boolean values
const boolValue = true
console.log('boolValue:', boolValue)

// symbols are unique no matter what
if (Symbol() == Symbol()) {
  console.log('This condition will never be met.')
}

// null vs. undefined:
const value = null             // meant to be use like an empty value (expected to be empty)
const doesNotExist = undefined // denotes a complete absence of a value
console.log('value:', value)
console.log('doesNotExist', doesNotExist)

// objects are just structs
let exampleObject = {
  stringField: 'this is a string field',
  'numberField': 52, // don't actually need quotes in key unless using disallowed characters in key name
  exampleMethod() { return 'this message is from a method' },
}
console.log('exampleObject:', exampleObject)
console.log('exampleObject.stringField:', exampleObject.stringField)
console.log('exampleObject.[\'numberField\']:', exampleObject['numberField'])
console.log('exampleObject.exampleMethod():', exampleObject.exampleMethod())
console.log('Object.keys(exampleObject):', Object.keys(exampleObject))
console.log('Object.values(exampleObject):', Object.values(exampleObject))

// uhOh = exampleObject.nonExistantProperty // this will fail because that field doesn't exist
const uhOh = exampleObject?.nonExistantProperty // this works and will return `undefined` because of the `?`
console.log('uhOh (exampleObject?.nonExistantProperty):', uhOh)
const thing = uhOh ?? 'the thing' // if the first object before the `??` is `null` or `undefined`, this will turn into the second value
console.log('thing (uhOh ?? \'the thing\'):', thing)

// arrays are heterogenous
const arrayExample = [1, 'test', 'hello', false, null]
console.log('arrayExample:', arrayExample)
console.log('arrayExample[1]:', arrayExample[1]) // arrays are 0-indexed
console.log('arrayExample.length:', arrayExample.length)
// arrays have methods for functional stuff (map, filter, etc...)

// use ** to raise to a power
console.log('2 ** 3 = 8:', 2 ** 3)

// division is always floating point
console.log('5 / 2 = 2.5:', 5 / 2)

// also has ++ and -- from C/C++

// two equalities
const a = '0'
const b = 0
console.log('a (string):', a)
console.log('b (number):', b)
if (a == b) {
  console.log('== converts values, which has some strange rules')
}
if (a === b) {
  console.log('on the other hand, ===, works like == in other languages, checking both value and type')
}

// standard `if`, `else if`, and `else` statements for flow control
// C-like `for` loops
// however, there are `for-of` loops for iterables:
for (const item of arrayExample) {
  console.log('for of loop example:', item)
}
// and `for-in` loops over keys of an object
for (const key in exampleObject) {
  console.log('for in loop example:', key)
}
// also has C-like switch statements

function exampleFunc1(test1, test2) {
  return test1 + " and " + test2
}
console.log('exampleFunc1(\'test1\', \'test2\'):', exampleFunc1('test1', 'test2'))
// functions can define default values for parameters
function exampleFunc2(test1, test2 = 'default value') {
  return test1 + " and " + test2
}
console.log('exampleFunc2(\'test1\'):', exampleFunc2('test1'))
console.log('exampleFunc2(\'test1\', \'test2\'):', exampleFunc2('test1', 'test2'))
// has lambda functions using:
// (parameters) => <opeation using parameters>
// OR:
// (parameters) => {
//   <operations using parameters>
// }

// classes are blueprints for objects
class Sport {
  constructor(name, athlete) { // constructor like `__init__` in Python
    this.name = name
    this.athlete = athlete
  }
}
const swimming = new Sport('swimming', 'michael phelps')
console.log('swimming:', swimming)

// there is inheritance using `extends`
class TeamSport extends Sport {
  constructor(name, athlete, teamSize) {
    super(name, athlete)     // super is for constructor of parent
    this.teamSize = teamSize // this is for current class
  }
}
const basketball = new TeamSport('basketball', 'lebron james', 5)
console.log('basketball:', basketball)

// using exceptions for error handling
try {
  JSON.parse("{ this is not json! }")
} catch (e) {
  console.log(e)
}
// use `throw new Error(...)` to raise an exception

// I'll figure out async later
