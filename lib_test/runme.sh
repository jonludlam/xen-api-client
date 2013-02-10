#!/bin/bash
echo "This takes longer than you might expect..."
ocamlfind ocamlc -package js_of_ocaml,js_of_ocaml.syntax,rpclib,rpclib.js,xen-api-client.lwt,lwt,lwt.syntax -annot -syntax camlp4o -linkpkg -g -o test.byte test.ml
js_of_ocaml -noinline -pretty test.byte
