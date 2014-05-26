fprofx (fprof extended)
======

fprofx adds suspend and GC time columns to the fprof output.
This is very useful when profiling compute that is spread accross may processes.

For example most of the work done during a call to `httpc:request` is not done by the calling
process but by already running processes. To get an accurate profile it is necessary to profile
all running processes. But most of those processes spend most of the time suspended. Finding where
the actual work is performed can be difficult.

erlgrindx is provided to convert fprofx output into callgrind format. See https://github.com/isacssouza/erlgrind for more detail.

## Usage

fprofx can be used in exactly the same way as fprof. The addition of suspend times makes
profiling all processes practical. For example, to profile a httpc request:

```Erlang
    inets:start(),
    %% Do initial request to force all code to be loaded
    {ok, _} = httpc:request("http://www.talko.com"),

    {ok, _} = fprofx:apply(
                httpc, request, ["http://www.talko.com"], 
                [{procs, processes() -- [whereis(fprofx_server)]}]),
    ok = fprofx:profile(),
    ok = fprofx:analyse([{dest, "fprofx.analysis"}]).
```

To open in kcachegrind:

```bash
./erlgrindx fprofx.analysis 
kcachegrind fprofx.cgrind 
```
