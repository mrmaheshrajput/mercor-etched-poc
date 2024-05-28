# Ubuntu: 22.04
# Instance: m5n.large

# Install miniconda
# Ref: https://docs.anaconda.com/free/miniconda/
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

# Init for shells
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

# Install python=3.9, ipykernel, jupyter and notebook
conda create --name vllm python=3.9 -y && conda activate vllm
conda install -c conda-forge jupyter==1.0.0 notebook==6.5.4 jupyter_contrib_nbextensions -y

#pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user

# Clone repo
git clone https://github.com/vllm-project/vllm && cd ./vllm

# Ref: https://docs.vllm.ai/en/latest/getting_started/cpu-installation.html
sudo apt-get update  -y
sudo apt-get install -y gcc-12 g++-12
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 10 --slave /usr/bin/g++ g++ /usr/bin/g++-12

#pip install --upgrade pip
pip install --no-cache-dir wheel packaging ninja setuptools>=49.4.0 numpy
pip install --no-cache-dir -v -r requirements-cpu.txt --extra-index-url https://download.pytorch.org/whl/cpu

# Setup kernel
python -s -m ipykernel install --user --name vllm --display-name "Python vllm"

# Install jupyter extension
pip install --no-cache-dir jupyter_http_over_ws
jupyter serverextension enable --py jupyter_http_over_ws


VLLM_TARGET_DEVICE=cpu python setup.py install
