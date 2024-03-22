;; learning how to do a "Hello, world!" in Wat using WASI

(module
  ;; import `fd_write`, which will write the given fectors to stdout
  (import "wasi_snapshot_preview1" "fd_write"
    ;; signature is:
    ;; (file descriptor, *iovs, iovs_len, *nwritten)
    ;; returns 0 on success, nonzero on error
    (func $fd_write (param i32 i32 i32 i32) (result i32))
  )

  (data (i32.const 8) "hello world\n")

  ;; memory:
  ;; this will allocate and export an array of bytes
  ;; the memory has to be at least 1 page (64 KB)
  (memory (export "memory") 1)

  ;; the string:
  ;; this will create a region of data containing the string "Hello, world!\n"
  ;; this string starts 8 bytes after the start of our linear memory
  (data (i32.const 8) "Hello, world!\n")

  ;; this is how the main function is defined
  (func $main (export "_start")
    ;; the following is creating an io vector within linear memory

    ;; `i32.store` is used to store an `i32` memory location

    ;; this stores the pointer to the start of our string `i32.const 8` at the
    ;; memory address `0`
    (i32.store (i32.const 0) (i32.const 8))
    ;; this stores the length of the string at the memory addres `4`, which we
    ;; are using because the previous expression stored an `i32` (which is 4
    ;; bytes long) to the `0` address, occupying the addresses from `0` to `3`
    (i32.store (i32.const 4) (i32.const 14))

    ;; here we call the `$fd_write` function we imported earlier
    (call $fd_write
      (i32.const 1)  ;; the file descriptor - 1 is for stdout
                     ;; this defines where the string should be written
      (i32.const 0)  ;; this is the pointer to the start of the io vector we
                     ;; defined in the `i32.store` expressions above
      (i32.const 1)  ;; means we are printing only 1 string that is stored in
                     ;; the io vector
      (i32.const 24) ;; the place in memory to store the number of bytes that
                     ;; are written
    )

    drop ;; discard the number of bytes written from the top of the stack
  )
)
