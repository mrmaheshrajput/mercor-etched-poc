# vLLM Proof of Concept with Jupyter Notebook

This repository contains the Jupyter Notebook and setup instructions for a Proof of Concept (POC) project demonstrating the use of Virtual Large Language Model (vLLM) library with a focus on connecting Jupyter Notebook on an EC2 instance with Google Colab for local runtime.

## Jupyter Notebook

The primary Jupyter Notebook for this POC can be found at [`vllm_quickstart.ipynb`](vllm_quickstart.ipynb) in the root directory of this repository.

## POC Sections

### Section 1: Setting up EC2 Machine

The setup for the EC2 machine is detailed in the script [`vllm_jupyter_colab_local_runtime.sh`](vllm_jupyter_colab_local_runtime.sh), also located in the root directory. This section focuses on configuring an EC2 instance, with particular emphasis on selecting an instance type that supports AVX-512 instructions. For this POC, the chosen EC2 instance type is `m5n.large`.

1. Launch a new `m5n.large` machine because it support AVX-512
1. SSH into the instance and bind host port to remote port
1. Install miniconda on the instance
1. Create new conda env `vllm` with `python=3.9` and other packages
1. Clone the [vllm](https://github.com/vllm-project/vllm) repo
1. Install vllm-cpu as per []official documentation](https://docs.vllm.ai/en/latest/getting_started/cpu-installation.html)
1. Setup jupyter kernel
1. Install `jupyter_http_over_ws` extension and enable it


### Section 2: Running Jupyter Notebook Server on EC2 and Connecting with Google Colab Local Runtime

In the second section, we establish a connection between the Jupyter Notebook server running on the EC2 instance and the local runtime of Google Colab. Below is the command used to initiate the Jupyter Notebook server on the EC2 instance:

```bash
jupyter notebook \
--NotebookApp.allow_origin='https://colab.research.google.com' \
--port=8888 \
--NotebookApp.port_retries=0 \
--NotebookApp.disable_check_xsrf=true \
--MultiKernelManager.default_kernel_name=vllm \
--no-browser
```

The URL returned by the jupyter server is used to connect to colab's local runtime.

Example output:
```bash
To access the notebook, open this file in a browser:
        file:///home/ubuntu/.local/share/jupyter/runtime/nbserver-789-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/?token=1de8eaf76583cbf33ae4b26e324b8f6eb90be8a4df92ab8b
     or http://127.0.0.1:8888/?token=1de8eaf76583cbf33ae4b26e324b8f6eb90be8a4df92ab8b
``` 


## Notes
1. [Instructions link](https://etched.notion.site/Mercor-proof-of-concept-work-8fa4f789fdaf4b54aa4409445ec05cac)
1. [YouTube video walkthrough](https://youtu.be/z0DsXsGCGOs)
