;; learning how to do a "Hello, world!" in Wat using WASI

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32))
  )

  (import "wasi_snapshot_preview1" "args_get"
    (func $args_get (param i32 i32))
  )

  (import "wasi_snapshot_preview1" "args_sizes_get"
    (func $args_sizes_get (result i32))
  )

  (memory (export "memory") 1)

  (func $main (export "_start")
    
  )
)
