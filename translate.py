from langchain_community.llms import Ollama
import os

llm = Ollama(model="translator")

def convert_rust_to_lean(rust_file_contents):
    prompt = rust_file_contents
    num_tokens = llm.get_num_tokens(prompt)

    print(f"Number of tokens: {num_tokens}")

    if num_tokens > 1000:
        print("Number of tokens exceeds the maximum limit of 1000")
        return ""

    lean_file_contents = llm.invoke(prompt)

    return lean_file_contents

def to_camel_case(snake_str):
    return "".join(x.capitalize() for x in snake_str.lower().split("_"))

    

# Copy the contents of the files to be translated into a corresponding Lean files

src = "revm/crates/primitives"
dst = "Levm/Primitives"
dstfolder = os.path.dirname(dst)
# if not os.path.exists(dstfolder):
#     os.makedirs(dstfolder)
# shutil.copy(src,dst)

for dirpath, dirnames, filenames in os.walk(top=src):
    # print(dirpath, dirnames, filenames)
    for file in filenames:
        if not file.endswith(".rs"):
            continue
        # canvert file from snake case to camel case
        camel_case = to_camel_case(file.removesuffix(".rs"))+".lean"

        srcfile = os.path.join(dirpath, file)
        dstfile = os.path.join(dst + dirpath.removeprefix(src), camel_case)
        print("src", srcfile, "dst", dstfile)

        dstfolder = os.path.dirname(dstfile)

        if not os.path.exists(dstfolder):
            os.makedirs(dstfolder)

        # Open the file we want to copy
        with open(srcfile, 'r') as srcf:
            data = srcf.read()
            print()
            print(data)
            print()
            # print(data)
            # print(llm.invoke(data))
            with open(dstfile, 'w') as dstf:
                dstf.write(convert_rust_to_lean(data))
                # dstf.write(llm.invoke(data))


        
# TODO investigate Modelfile syntax more to create a better prompting system with more examples
# TODO iteratively improve the model with corrections to the Lean code it generates