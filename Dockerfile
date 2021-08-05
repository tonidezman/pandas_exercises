FROM jupyter/scipy-notebook:33add21fab64

USER root

RUN apt update
RUN apt install neovim -y

# Dependencies for PDF dlownloader inside Jupyter Notebook
RUN apt install texlive-xetex texlive-fonts-recommended texlive-latex-recommended -y

# chose jupyter theme
RUN pip install jupyterthemes
RUN jt -t onedork

# Install vim plugin for Jupyter Notebook
RUN apt install git -y
RUN mkdir -p $(jupyter --data-dir)/nbextensions
RUN cd $(jupyter --data-dir)/nbextensions && git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
RUN jupyter nbextension enable vim_binding/vim_binding

WORKDIR /app
COPY . .

EXPOSE 8888
CMD exec jupyter notebook --ip 0.0.0.0 --no-browser --allow-root
