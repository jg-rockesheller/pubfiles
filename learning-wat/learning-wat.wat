;; the data types are:
;; i32, i64, f32, f64
;; these are ints and flaots

;; to define functions:
;; (func <signature> <locals> <body>)

;; WASM is stack based
;; i think i understand what this means
;; like a stack data structure
;; implemented something similar in Haskell through Reverse Polish Notation

(module
  ;; the function is called `$add`
  ;; the second parameter is named `$p1`
  (func $add (param i32) (param $p1 i32) (return i32)
    ;; you can access parameters from index or name
    local.get 0   ;; this will get the first param
    local.get $p1 ;; this will get the param labeled `$p1`
    i32.add     ;; takes the last two elements on the stack and adds them (as long as they are both i32)
  )
  (export "add" (func $add)) ;; here we export this function

  ;; calling function from one module in another
  (func $getAnswer (result i32) i32.const 42) ;; this is basically like defining an i32 variable
  ;; here we automatically export this function with the name `getAnswerPlus1`
  (func (export "getAnswerPlus1") (result i32)
    call $getAnswer ;; here the result from `$getAnswer` is put on the stack
    i32.const 1
    i32.add
  )
  ;; to call a function with parameters, do:
  (func (export "getAnswerPlus2") (result i32)
    call $add $getAnswer 2
  )
)