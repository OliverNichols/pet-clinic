# pet-clinic   
## Contents
* [Introduction](#introduction) 
  * [Objective](#objective)
  * [Proposal](#proposal)
* [Architecture](#architecture)
  * [Risk Assessment](#risk-assessment)
  * [Kanban Board](#kanban-board)
  * [Burndown](#Burndown)
* [Infrastructure](#infrastructure)
  * [Pipeline](#pipeline)
  * [Refactoring](#Refactoring)
* [Cost analysis](#Cost-analysis)
  * [Virtual machines](#Virtual-machines)
  * [Infrastructure](#Infrastructure) 
  * [Final costs](#Final-costs)
* [Evaluation](#Evaluation)
* [Footer](#footer)

## Introduction

### Objective
The objective for this group project was to deploy a spring petclinic application that runs on AngularJS alongside a Java API in order to demonstrate our ability to utilise DevOps tools to provide continuous integration and delivery even with applications and languages we are unfamiliar with. We must find our own solution and decide on the tools we believe will work best as well as demonstrate our workflow.

Further requirements include:

* Environment-agnostic deployment
* Justification for use of tools
* Cost analysis


### Proposal

Our approach to this project is to utilise the Azure DevOps Pipelines interfaced with a Github webhook for the repository for automated continuous integration and delivery. We use this pipeline to test the application using Karma, build and push it with Docker to Nexus, set up host configuration with Terraform and deploy it with Kubernetes. 

The reason we decided on the Azure DevOps Pipelines was because our resources were created in Azure and several `az` commands are required in our configuration and the Azure DevOps Pipelines tool is designed to be easily integrated with the Azure Portal. 

Karma was used simply because the application's tests were designed for it and, while some reconfiguration within the applications scripts were required, it was significantly more efficient to use Karma over building a new test structure.  

Docker was used to build and push the application. Similar to the choice of Karma, the application is already configured to work with Docker images so this choice would be much more efficient than alternatives.  

Terraform was selected because it can do all the infrastructure on any cloud platform in one language. It is also really easy to make changes to and will let you know exactly what it will change which is extremely useful for such an experimental project.

Kubernetes was used because Azure has its own managed Kubernetes services (AKS) which helps configure and deploy our clusters. This combined with its integratability with Docker, its easy scalability, and its portability made it the ideal choice for the project.

## Architecture

### Risk Assessment

This is our initial risk assessment created during our sprint planning meeting.  
![risk][risk]

This is our final risk assessment from near the end of the sprint.  
![risk2][risk2]

Noticeable changes include the addition of an evaluation for the risks, as well as some new and modified assessments.

### Kanban Board

We used Trello as a Kanban Board in order to track our project, seen below.

![Kanban][kanban]

Here is the link to view our board: https://trello.com/b/Uq1lOfCr/group-project-team-3

The Trello board has the following sections:

* Project resources - Links to parts of our project and list of special team roles
* User stories - What the users want and why. This is used to not lose focus of why we have our tasks to help find solutions or alternatives when needed. These user stories are treated the same as other requirements, and so are moved around during sprints (but are tagged with `User Story` label).
* Backlog - Incomplete tasks and requirements.
* Sprint Backlog - Backlog for current sprint.
* In Progress - Tasks currently being worked on.
* Sprint 1: Complete - Completed tasks in sprint 1.
* On hold - Tasks not to be completed for now but could be done in future.

Tasks have also been tagged using MSCW prioritisation (Must, Should, Could, Won’t), as well as tags for the task's type and the task's asignee. 

### Burndown

Here you can see our burn-down chart.

![Burndown][burndown]

The above shows the completion of tasks throughout the sprint as well as the effort of both tasks completed and work done measured relative to one another. It also shows the ideal completion rate, or “burndown”,  and the remaining tasks and effort for the sprint.

Below you can see a table of the major tasks and their relative effort.  

![bdtable][bdtable]


## Infrastructure

### Pipeline

Below is a diagram of our CI/CD pipeline.

![cicd][cicd] 

The development section represents the workflow of the developers, rather than our own development environment related to the infrastrcture and not the app itself. As a developer pushes changes to the `dev` branch of the [application's repo](https://github.com/pet-clinic-team-3/spring-petclinic-angular) will trigger a development version of the pipeline which has a variable IP address and some other configurations set up. If the developer pushes changes to the `main` branch of said repo then a production pipeline will trigger instead, eventually deploying onto the production environment.

This seperation allows developers to run dynamic tests on a development environment without risk of affecting the production environment - this was one of the requirements of the project.

**Steps**

Once all dependencies are installed, the following steps are followed:

1. Testing: runs unit tests on the application via a headless version of karma so that the tests are automated and displayed in the build terminal.
2. Build + Push: front-end application is built into an image via Docker and pushed to a secure private Nexus repository.
3. Configuration: the resource group and kubernetes cluster are configured ready for deployment on the dev/prod environment.
4. Deploy: both the front-end and back-end API of the application are deployed.  
<br/>

Below you can see photos of the actual pipeline, the test results displayed in the pipeline, and the application working after the pipeline build (the final image demonstrates it working in tandem with the back-end. 

![pipeline][pipeline]

![front][front]

![back][back]

### Refactoring

In this section we will briefly discuss some of the improvements made throughout the sprint.

The first change made for this project is switching our webhook to trigger on the application's Github repository instead of our infrastructure repository. This meant that changes from the developers would trigger the webhook making it more realistic to the goals of the project. This also made the pipeline stages simpler as less directory changing is required with the application being the heart of the environment. Refactoring of our pipeline scripts were required to accommodate this change however the change has allowed for them to be made slightly simpler than the originals. 

The next change was incorporating Nexus into the project. Initially we used DockerHub to store our images, however DockerHub repositories are typically public and additionally cannot be customised, whereas Nexus can. This did require significant refactoring for our Kubernetes setup as well as creating a Nexus host but ultimately gave us more control over our repository and security making it an ideal change. In order to get Nexus working with Kubernetes we did also have to set up a https connection using an SSL certificate which could potentially add costs to the user in the long-run (but would be free for at least a year, and is still relatively cheap).

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


## Evaluation

For the evaluation we will discuss what we did well, what issues we had, and what we can do differently in the future. 

**Strength #1**  
Overall we believe the project went fairly well. Our work methodology seemed to prove effective with each of us focusing on building specific parts for the pipeline while coming together to problem solve whenever someone has a serious blocker. Due to the testing, building and pushing stages being the quickest to set up the 2 members of the group responsible had more freedom to aid the other team members on their sections after reaching the MVP for their sections allowing for an ideal balance of group support and individual focus. Our strong communication during stand-ups and throughout the project further allowed us to have clear daily individual and group goals and an understanding of where everyone is with their work so we would know who may need assistance and who may be available to provide it.

**Strength #2**  
We also demonstrated strong of use of tools with which we had little-to-no familiarity. The Java application we deployed was not only a foreign application to us but a language most of the team was not familiar with. We were all able to utilise our tools with the application and some of us even made alterations to the Java scripts themselves to better integrate them with our DevOps technologies. As for the technologies we used, with the exception of Docker they were all tools we either had little or no experience with and yet we all utilised them to create an effective deployment.

**Issue #1**  
We did struggle however with some of our technologies. Integrating Kubernetes and Terraform into one step proved challenging and ultimately too time consuming so in the end we implemented them as separate pipeline steps working one after the other instead of in unison. This isn’t a huge issue as they both performed their roles but it does mean that the pipeline takes longer to build and more would need to be done to account for changes to one or the other. We had similar struggles with implementing Nexus but did eventually get it working with the project.

**Issue #2**  
A tool that was abandoned completely was Protractor which was to be used for end-to-end testing. This ultimately proved too troublesome to implement in this sprint and as such our end-to-end testing had to be done within our testing environment directly after the development pipeline builds, even though it would be prudent to test the application works properly upon each build. Specifically, testing integration functionality with the API each time does cost extra time between setting up the development pipeline and feeling confident in pushing to main.

**Issue #3**  
Another issue we faced was in knowing when something was ready to integrate with the pipeline. For our Kubernetes and Terraform we tried to get them optimised before integrating into the pipeline which caused pressure on our time constraints. This is because we didn’t begin implementation until our last day causing worry we would not have a fully functional product by the end of the sprint. We should have began implementing them upon reaching an MVP so that we would have a fully functional pipeline before beginning optimisation which is definitely what we do in future. 

**Improvements**  
There are quite a few other improvements we can make in future sprints. The first improvement would be implementing the end-to-end testing into the pipelines to further automate the process. Something else we could’ve done differently is keeping better track of our costs at the start of the project. While some of us did have budgets set to alert us of costs we were not deleting our resources in our temporary resource groups at the end of the day to save on costs and when we exceeded our budgets we did not set new ones to track future costs and did not often discuss strategies or plan to reduce our costs which will we have to do in future.

## Footer

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
[risk2]: https://i.imgur.com/R4i43u7.png
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
[pipeline]: https://i.imgur.com/2qq6Sg8.png
[front]: https://i.imgur.com/LPE1ds4.png
[back]: https://i.imgur.com/2poQ7ZR.png