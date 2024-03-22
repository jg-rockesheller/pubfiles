var anyVariable; // type script makes this variable an `any` type, meaning it can be of any other type
anyVariable = 'string';
console.log('anyVariable:', anyVariable);
anyVariable = false;
console.log('anyVariable:', anyVariable);
var stringVariable = 'this variable can only a string';
console.log('stringVariable:', stringVariable);
var numArrVariable = [1, 2, 3, 4];
console.log('numArrVariable:', numArrVariable);
// define parameter and return types
function devour(quantity) {
    console.log('Devouring cakes');
    return quantity >= 4;
}
console.log('devour(10)', devour(10));
console.log('devour(3)', devour(3));
