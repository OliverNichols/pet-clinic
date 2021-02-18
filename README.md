# pet-clinic   
## Contents
* [Introduction](#introduction) 
  * [Objective](#objective)
  * [Proposal](#proposal)
* [Architecture](#architecture)
  * [Risk Assessment](#risk-assessment)
  * [Kanban Board](#kanban-board)
  * [User stories](#user-stories)
  * [Burndown](#Burndown)
* [Infrastructure](#infrastructure)
  * [Pipeline](#pipeline)
  * [Refactoring](#Refactoring)
* [Cost analysis](#Cost-analysis)
  * [Virtual machines](#Virtual-machines)
  * [Infrastructure](#Infrastructure) 
  * [Final costs](#Final-costs)
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
![risk][risk]
### Kanban Board

For our Kanban board we used Trello to track our project and you can see our board below.

![Kanban][kanban]

Here is the link to view our board: https://trello.com/b/Uq1lOfCr/group-project-team-3

The Trello board has the following sections:

* Project resources- Links to parts of our projects and list of special team roles
* User stories- What the user wants and why. This is used to not lose focus on why we have our tasks to help find solutions or alternatives when needed. Most user stories are tagged with this label but in other sections.
* Backlog- Incomplete tasks and requirements.
* Sprint backlog- Backlog for current sprint.
* In progress- Tasks currently being worked on
* Sprint 1 complete: Completed tasks
* On hold- Tasks not to be completed for now but could be done in future.
 
We also have tags to show a tasks priority (Must, Should, Could, Won’t) as well as tags for the tasks type and the task owner. 

### User stories

### Burndown

Here you can see our Burndown chart.

![Burndown][burndown]

The above shows the completion of tasks throughout the sprint as well as the effort of both tasks completed and work done measured relative to one another. It also shows the ideal completion rate or “burndown”  and the remaining tasks and effort for the sprint.

Below you can see a table of the major tasks and their relative effort.

![bdtable][bdtable]


## Infrastructure

### Pipeline

Below is a diagram of our CI/CD pipeline.

![cicd][cicd] 

The development section at the top has dual representation. During this sprint the programming and refactoring section represents the changes made to our build solution and infrastructure which during the earlier stages would trigger a webhook when pushed to Github. In this case the Trello board is our board with the work for our solution which informs the work to be done and is updated as work is done. The other representation is for the developers working on the front end of the app as in our final build the webhook is now triggered on the application repo on Github when developers make changes to it and so their development would work in much the same way.

In both cases, the webhook triggers the pipeline build to begin.  There is a pipeline and webhook both for the development branch and main branch of the repository and as the diagram demonstrates the pipelines build to different environments hence the as-live and production servers. This allows developers to test the build in a separate environment before committing to the user facing one.

The first step is that all dependencies for the build are installed in the pipelines temporary environment so that it can perform the other steps without further installations. Next it runs unit tests on the application via a headless version of karma so that the tests are automated and displayed in the build terminal. Once all the tests pass the front end application is then built into an image via Docker and pushed to a secure private nexus repository.  Terraform is then used to configure the hosts for the deployment and due to the nature of Terraform only changes to the configuration are implemented meaning if there are little to no changes to the configuration this step will account for that and the step finishes very quickly. Finally Kubernetes is used to deploy both the front end application the developers would be working with along with the back end API it utilises that is stored on Dockerhub to an azure hosted cluster. With Kubernetes the scaling is automated by the azure host and no additional work needs to be done to account for changes in traffic.

Below you can see photos of the pipeline in progress, the test results displayed in the pipeline and application working after the pipeline build. 

PLEASE INSERT IMAGES

### Refactoring

In this section we will briefly discuss some of the improvements made throughout the sprint.

The first change made for this project is switching our webhook to trigger on the application Github repository instead of our build. This meant that changes from the developers would trigger the webhook making it more realistic to the goals of the project. This also made the pipeline stages simpler as less directory changing is required with the application being the heart of the environment. Refactoring of our pipeline scripts were required to accommodate this change however the change has allowed for them to be made slightly simpler than the originals. 

The next change was incorporating nexus into the project. Initially we used Dockerhub to store our images however Dockerhub repositories are typically public and additionally cannot be customised whereas nexus can. This did require significant refactoring for our Kubernetes setup as well as creating a nexus host but ultimately gave us more control over our repository and security making it an ideal change. 

## Cost analysis

This section will focus on the costs of our project so far as well as the project costs moving forward. 

### Virtual machines

Below are all the resource groups needed to manage virtual machines and their costs from the start of the project until 17.02.2021. These are also our temporary resources. Virtual machines were needed to provide fresh environments for each build attempt in order to mimic the pipelines environment so that the entire process for each of the stages can be built for automation. 

![testcost][testcost]

This was the cost of running the tests on virtual machines for the project (£0.85). Even though this data goes until February 17th the data ends at the 16th because that was when testing was completed and implemented into the pipeline and so the resource group deleted. As a result there are no projected costs for this group however for future sprints end to end testing could be implemented that will run up similar costs as the same size virtual machines (B2s) will need to be used to handle the applications and CPU usage needed for testing. So projected testing cost for the next sprint is £0.85.

![buildcost][buildcost]

This was the cost of running the build and push stages for the project (£4.85). As this has now been completed and implemented into the pipeline the resource group has been deleted and there are no projected future costs.

![kubevmcost][kubevmcost]

This was the cost of the Kubernetes virtual machines (£2.64). At time of writing Azure has no calculated the cost for 18.02 which is the final day this group needed to remain active as such the projected cost for this resource group for this sprint is £3.00 maximum and there are no projected costs for future sprints as it is integrated into the pipeline.

![terracost][terracost]

This was the total costs for Terraform. The cost for the virtual machine resource group is £0.74. As this is now also done through the pipeline the resource group is deleted and there are no projected costs. 

The total costs of virtual machines for this sprint is £9.08 current and is projected to be £9.44 For the next sprint this cost is expected to be the end to end testing costs for a total of £0.85.

### Infrastructure

This section covers the costs of running the infrastructure moving forward. These can be considered our permanent resources.

From the final image in the above section you can see the costs for running the terraform configuration is £1.42. This was the running cost for 2 days giving us £0.71 per day. There is one day left in the first sprint at time of writing so the projected cost for this sprint is £2.13. For future sprints this should remain consistent giving us a projected cost of £4.97.

![pipecost][pipecost]

As you can see from the above picture Microsoft's azure pipelines allow for 1 free job so the cost of running the pipeline is nothing. In case of multiple projects being required the projected sprint costs of using a Microsoft-hosted job is approximately £7.50. 

![nexuscost][nexuscost]

This was the cost of running nexus as our docker repository(£3.22). The reason for the low initial cost followed by a consistent incline is because the size was upscaled significantly. As this needs to be run persistently to store the docker images the costs are projected to remain consistent at around 60p per day. So for the end of this sprint the final cost should be approximately £3.82. For a future week long sprint the projected costs for this resource is £4.80.

![kubecost][kubecost]

The cost of running our Kubernetes was £13.41. This is by far the most expensive resource as an expensive virtual machine (D series) is automatically put in place to host the cluster.  The per day costs have reduced towards the end of the sprint as experimentation was significantly heavier towards the beginning. Due to the fluctuation in cost per day we have decided to take the final day cost as a predictive model as that is the setup closest to our final design giving us an estimated cost of £1.20 per day.  As there is one day left of the sprint yet to be analysed by Microsoft the projected cost for this sprint is £14.61. For the next sprint the projected cost is estimated to be £8.40. 

The total cost for infrastructure for this sprint is £18.05 currently and is expected to be £20.56. The projected cost for the next sprint is expected to be approximately 18.71, however should our pipeline no longer be our free job  this cost will rise to 25.67.

### Final costs

The final costs for this sprint are £27.13 currently and are predicted to be £30. The predicted costs for the next sprint are expected to be £19.56 or £27.06 with paying for the pipeline. Predicting future costs will be significantly easier moving forward especially in regard to our infrastructure groups as azure offers it’s own predicted cost forecasts for any resource groups open longer than 8 days so going from our next sprint we should have automated predictions that we can use to aid in formulating our own. 

The reason for the considerably higher cost for this sprint is because this was the initial set up sprint requiring a lot of temporary resources in order to design and build the infrastructure. In all likelihood there will still be more temporary resources used in future however with the exception of end to end testing any likely builds needed in future will be built on top of our pre existing pipeline stages meaning that they will either be tested directly on the pipeline or that building times for each resource will be extremely short and it will be rare that resource groups created will exist long enough to run up costs higher than a few pennies.  

During this sprint several temporary resource groups were up for days at a time which ran up our costs more than necessary. Going forward at the end of each day after our files are pushed to Github  all resources within these temporary groups will be deleted to save money but also to keep the group open so there is one cost analyses for each pipeline stage per sprint.

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



[risk]: https://i.imgur.com/3MGczIo.png
[kanban]: https://i.imgur.com/6FfuU4t.png
[burndown]: https://i.imgur.com/zZntHmh.png
[bdtable]: https://i.imgur.com/5Jru4fm.png
[testcost]: https://i.imgur.com/qEq0ZuF.png
[buildcost]: https://i.imgur.com/DxaA1yi.png
[nexuscost]: https://i.imgur.com/H4huVmO.png
[kubevmcost]: https://i.imgur.com/Qg8XXdg.png
[terracost]: https://i.imgur.com/erN12NJ.png
[pipecost]: https://i.imgur.com/eFasIWn.png
[kubecost]: https://i.imgur.com/1weQx8U.png 
[cicd]: https://github.com/pet-clinic-team-3/pet-clinic/blob/feature-readme/images/pipeline.png
