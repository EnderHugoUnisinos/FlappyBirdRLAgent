# RLAgents na Godot

## Flappy Bird

Estrutura de cenas:

MAIN
| Contém BIRD assim como o controlador da IA (recompensas, fim, etc) 
| Código faz o spawn de canos 

PIPEPAIR
| Contém canos e area segura (gap)
| Canos se ordenam a partir de um ponto central com Y aleatorio

BIRD
| Contém o personagem principal
| Está em estado de queda por padrão e pode pular ao receber um input

Fontes externas utilizados:

* Godot RL Agents
* Stable Baselines 3
