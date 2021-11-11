# swift-bug

No problem in Xcode (run)
No promlem in cli (swift build && .build/debug/Run)
Problem in linux

1. Build container `docker build -t hiimtac/swift-bug .`
2. Open container `docker run -it --privileged hiimtmac/swift-bug bash`
3. LLDB `lldb .build/debug/Run`
4. Run program `run` -> should segfault
5. `bt`

```
root@531888c25919:/# lldb .build/debug/Run
(lldb) target create ".build/debug/Run"
Current executable set to '/.build/debug/Run' (x86_64).
(lldb) run
Process 19 launched: '/.build/debug/Run' (x86_64)
starting
[1]
Process 19 stopped
* thread #4, name = 'Run', stop reason = signal SIGSEGV: invalid address (fault address: 0x0)
    frame #0: 0x00007ffff75f2e50 libswiftCore.so`swift::metadataimpl::ValueWitnesses<swift::metadataimpl::SwiftRetainableBox>::destroy(swift::OpaqueValue*, swift::TargetMetadata<swift::InProcess> const*)
libswiftCore.so`swift::metadataimpl::ValueWitnesses<swift::metadataimpl::SwiftRetainableBox>::destroy:
->  0x7ffff75f2e50 <+0>: movq   (%rdi), %rdi
    0x7ffff75f2e53 <+3>: jmp    0x7ffff75efe30            ; swift_release
    0x7ffff75f2e58:      nopl   (%rax,%rax)
libswiftCore.so`swift::metadataimpl::ValueWitnesses<swift::metadataimpl::SwiftRetainableBox>::initializeWithCopy:
    0x7ffff75f2e60 <+0>: pushq  %r14
Target 0: (Run) stopped.
(lldb) bt
* thread #4, name = 'Run', stop reason = signal SIGSEGV: invalid address (fault address: 0x0)
  * frame #0: 0x00007ffff75f2e50 libswiftCore.so`swift::metadataimpl::ValueWitnesses<swift::metadataimpl::SwiftRetainableBox>::destroy(swift::OpaqueValue*, swift::TargetMetadata<swift::InProcess> const*)
    frame #1: 0x00007ffff77b9db6 libswift_Concurrency.so`_asyncLet_finish_continuation(swift::AsyncContext*, void*) + 86
    frame #2: 0x00007ffff77b86eb libswift_Concurrency.so`swift::runJobInEstablishedExecutorContext(swift::Job*) + 187
    frame #3: 0x00007ffff77b8ce8 libswift_Concurrency.so`swift_job_run + 72
    frame #4: 0x00007ffff701d435 libdispatch.so`_dispatch_continuation_pop + 357
    frame #5: 0x00007ffff701d1e3 libdispatch.so`_dispatch_async_redirect_invoke + 211
    frame #6: 0x00007ffff7029142 libdispatch.so`_dispatch_worker_thread + 514
    frame #7: 0x00007ffff709a609 libpthread.so.0`start_thread + 217
    frame #8: 0x00007ffff6ed9293 libc.so.6`__clone + 67
(lldb) 
```
