# pet-clinic   
## Contents
* [Introduction](#introduction) 
  * [Objective](#objective)
  * [Proposal](#proposal)
* [Architecture](#architecture)
  * [Risk Assessment](#risk-assessment)
  * [Kanban Board](#kanban-board)
* [Infrastructure](#infrastructure)
  * [Pipeline](#pipeline)
* [Footer](#footer)

## Introduction

### Objective
The objective for this group project was to deploy a spring petclinic application that runs on AngularJS alongside a Java API in order to demonstrate our ability to utilise DevOps tools to provide continuous integration and delivery even with applications and languages we are unfamiliar with. We must find our own solution and decide on the tools we believe will work best as well as demonstrate our workflow.

Further requirements include:

* Multiple environment support
* Justify tool use
* Show cost analysis


### Proposal

Our approach to this project is to utilise the azure DevOps pipeline interfaced with a Github webhook for the repository for automated continuous integration and delivery. We use this pipeline to test the application using Karma, build and push it with Docker to Dockerhub, set up host configuration with Terraform and deploy it with Kubernetes. 

The reason we decided on the DevOps pipeline was because our resources were created in azure and several az commands are required in our configuration and the azure DevOps pipeline is designed to be easily integrated with the azure portal. 

Karma was used simply because the applications tests were designed for it and while some reconfiguration within the applications scripts were required it was significantly easier and quicker than building new tests would have been.

Docker was used to build and push the application partly because of our familiarity with Docker and partly because the back end API was already stored in Docker hub and it would save time and effort to have both applications stored and containerised in the same manner.

The reason Terraform was selected was because it can do all the infrastructure on any cloud platform in one language. It is also really easy to make changes and it will let you know exactly what it will change which is extremely useful for such an experimental project.

Kubernetes was used because Azure has it’s own managed Kubernetes services which help configure and deploy our clusters. This combined with it’s functionality with Docker it’s easy scalability and it’s portability made it the ideal choice for the project.

## Architecture

### Risk Assessment
![risk][imgur]
### Kanban Board

## Infrastructure

### Pipeline

## Footer

### Future Improvements

### Contributors
- [Oliver Nichols](https://github.com/OliverNichols)  
- [Michael Bunko](https://github.com/MBunko)  
- [Abaseen Popal](https://github.com/abaseen-popal)  
- [Yusuf Yasin](https://github.com/ykyasin)  
- [Naserul Islam](https://github.com/Nas-Islam)  

### Acknowledgements
- [Harry Volker](https://github.com/htr-volker)  
- [Dara Oladapo](https://github.com/DaraOladapo)



[Imgur]: https://i.imgur.com/3MGczIo.png
