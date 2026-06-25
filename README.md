# RLAgents na Godot

## Flappy Bird

### Execução:
Arquivos de execução do jogo para linux e windows na pasta build/ <br/>
Arquivo .sh para execução de codigo de Demo/Treinamento só está disponivel no Linux, no entanto creio que a logica é a mesma <br/> 
Parametros do stable_baselines3, compilação em python do arquivo "stable_baselines3_flappybird.py" com environment path ./build/Flappy (.exe / .x86_64)

#### demo no linux: <br/>
python3 stable_baselines3_flappybird.py --env_path ./build/Flappy.x86_64 --resume_model_path models/flappy_ppo_final.zip --inference --viz --timesteps 10000

#### treinamento no linux (200.000 timesteps): <br/>
python3 stable_baselines3_flappybird.py --env_path ./build/Flappy.x86_64 --experiment_dir logs/flappy --experiment_name ppo_final_run --timesteps 200000 --save_checkpoint_frequency 25000 --n_steps 256 --batch_size 128 --n_parallel 4 --viz --save_model_path models/flappy_ppo_final



### Estrutura de cenas:

MAIN<br/>
| Contém BIRD assim como o controlador da IA (recompensas, fim, etc) <br/>
| Código faz o spawn de canos 

PIPEPAIR <br/>
| Contém canos e area segura (gap)<br/>
| Canos se ordenam a partir de um ponto central com Y aleatorio

BIRD<br/>
| Contém o personagem principal<br/>
| Está em estado de queda por padrão e pode pular ao receber um input

### Fontes externas utilizados:

* Godot RL Agents
* Stable Baselines 3
