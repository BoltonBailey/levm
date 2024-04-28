
# Lean EVM

This repo is an experimental port of the [REVM](https://github.com/bluealloy/revm) Rust EVM implementation to Lean4. The port is intended to mainly work on the basis of using an LLM to give an initial rough buggy translation, which can then be modified by hand.

## Running the Port

To run the port as I have it, you will have to do several things:

* Install [Ollama](https://ollama.com/) (Doubt any of this works on Windows)
* Install `llama3:70b` via `ollama pull llama3:70b`
  * Alternativey, install `starcoder2:15b` and change the Modelfile and python script to match.
* Run `ollama create translator -f ./Modelfile` to create the model with the rust-to-lean4 prompt
* Install `langchain_community` via `pip install langchain_community`
* Run `translate.py`

