let anyVariable // type script makes this variable an `any` type, meaning it can be of any other type
anyVariable = 'string'
console.log('anyVariable:', anyVariable)
anyVariable = false
console.log('anyVariable:', anyVariable)

const stringVariable: string = 'this variable can only a string'
console.log('stringVariable:', stringVariable)

const numArrVariable: number[] = [1, 2, 3, 4]
console.log('numArrVariable:', numArrVariable)

// define parameter and return types
function devour(quantity: number): boolean {
  console.log('Devouring cakes')
  return quantity >= 4
}
console.log('devour(10)', devour(10))
console.log('devour(3)', devour(3))

// `unknown` is a safe alternative to `any`
// `never` represents values that should never occur

// make our own `enum`s
enum StarWarsCharacters {
  LukeSkyWalker,
  DarthVader,
  R2D2,
}

// computed `enum` members all have to have a initialiazer
// enum Dogs {
//   Fido = getID(),
//   Jack = getID(),
//   Kuro, // will result in an error because there is no intializer
// }

enum Season {
  Spring = 'SPRING',
  Summer = 'SUMMER',
  Autumn = 'AUTUMN',
  Winter = 'WINTER',
}

// `enums` can be heterogenous
enum MaybeBoolean {
  No = 0,
  Yes = 'YES',
}

// fixed size and
let tuple: [number, string, boolean] = [1, 'One', true]
