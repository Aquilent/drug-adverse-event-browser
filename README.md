## Drug Reaction Finder
Link to production prototype: [(http://gsa-ads-2-elbwebex-8jb6jmg989jy-1215229994.us-east-1.elb.amazonaws.com/)](http://gsa-ads-2-elbwebex-8jb6jmg989jy-1215229994.us-east-1.elb.amazonaws.com/)
### Aquilent’s Agile History
Aquilent is committed to Agile delivery methodologies that yield successful technology solutions across the Federal sector. Of particular note, Aquilent provides full-stack, Agile-based digital services for Healthcare.gov. In 2014, CMS chose Aquilent to lead key facets of the marketplace rehabilitation effort. Utilizing an Agile approach, we produced transactional solutions that directly facilitated the recently concluded, highly successful open enrollment period. Additionally, Aquilent utilized an Agile approach to design and develop the Healthy Living Assessment (HLA) for the Department of Veterans Affairs; an interactive tool that supports improved health care decisions for our nation’s Veterans.
### Project Planning
Aquilent is deeply committed to user-centered design principles that can properly inform our Agile development processes. Based on content available in the OpenFDA dataset, Aquilent began by conducting research with target users. The goal was to determine a large-scale health problem we could attempt to solve in a short period of time that would have the greatest **impact on citizens**.

Our research confirmed that citizens were concerned about having “bad reactions” to one or more drugs they were taking. Based upon adverse drug event reporting data the [OpenFDA dataset](https://open.fda.gov/drug/event/) provided, we began orienting our efforts around a solution that would allow citizens to search for adverse events for the drug(s) they were currently taking or considering, thereby empowering users to make better informed health decisions using multiple devices **(Play 2)**. Our Minimum Viable Product (MVP) solution prototype was labeled **Drug Reaction Finder** and was delivered in just eight days. We continued to ship product as the RFQ was extended.
### Methodology & Guiding Principles
Our Agile methodology for this and all Aquilent projects was based on the following guiding principles: 
*	**Solution Impact** — our research confirmed there was a user need for **Drug Reaction Finder**, and was further supported by FAERS statistics and medical attention on drug reactions (e.g. the [2014 ADE Prevention Conference](http://www.health.gov/hcq/ade.asp) to ‘identify opportunities that ensure safe and high-quality care for patients prescribed anticoagulants, diabetes agents, and opioids.’).
* **User-Centric** — researched user needs to create a **useful _and_ usable** solution, ensuring user needs were the center of all design and development decisions, validating with usability testing and making iterative improvements based on results, while also adopting a mobile-first design approach **(Play 1)**
* **Iteration** – held daily Scrum team meetings to discuss the collection of user feedback.  As a result, launched short-cycle design and development releases to GitHub to make user-focused improvements
* **Rapid Delivery** — Aquilent performed continuous deployment, based on user stories, to an AWS IaaS environment that facilitated rapid feedback on our short-cycle Sprints
* **Default to Open** — chose proven, open-source languages and tools, such as PHP, Laravel, Twitter Bootstrap **(Play 2)**, JQuery, Google Fonts, Linux, Docker, Jenkins, Vagrant, VirtualBox, and Chef **(Play 8, 13)**

### Scrum Team & Sprints
Aquilent worked as an integrated, collaborative, cross-functional Scrum team **(Play 7)**. Importantly, our team was entirely comprised of full-time Aquilent employees, offering further evidence of our ability to quickly mobilize full-stack teams in response to emerging needs under this BPA. Our project team included the following roles:
* Product Manager
* Delivery Manager
* Visual Designer
* Backend Web Developer
* Interaction Designer/User Researcher/Usability Tester
* DevOps Engineer
* Frontend Web Developer
* Frontend Web Developer (QA Tester)
* Technical Architect
* Business Analyst 
* Writer/Content Designer/Content Strategist

The Product Manager **(Play 6)** was our single interface with the 18F customer, representing all views and needs of the customer, and held overall accountability for the product.  **Sprint 1** focused on essential functions for the prototype, adding user stories to Backlog to establish a framework for future iterations. All work plans were loaded into a JIRA Agile board to assign responsibility and track accountability **(Play 4)**.  As part of our budget process, our Business Analyst and Technical Architect worked with the Product Manager to align resources with deliverables **(Play 5)**.

For **Sprint 2** (added due to RFQ extension), we held a Scrum to add a short-cycle Sprint to the schedule. Sprint 2 focused on high-priority Backlog items, including two major usability enhancements, driven by usability test results. When Sprint 2 was completed, we conducted an additional round of usability testing to validate usability of Sprint 2 enhancements.

### User Experience (UX) Research & Design
Using research-based, human factors techniques, we ensured that end-user needs were in focus throughout the entire project lifecycle. Techniques included:
* **User Interviews** — asked representative users questions about drug concerns and top tasks to directly guide prototype requirements
* **Persona** — based on interviews with users and additional audience research, Aquilent began developing preliminary personas **(Play 1, 2, 3)** to guide our design and development processes
* **Information Architecture (IA)** — leveraging user needs and top tasks, Aquilent created a mobile-first IA and content strategy, creating wireframes and low- and high-fidelity prototypes to diagram user flows
* **Visual Design** — produced a clean, responsive design to support all screen sizes and platforms and created a style guide **(Play 3)** to document design guidelines
* **Usability Testing** — conducted task-based usability testing with representative users to collect feedback.  Conducted testing on the initial prototype, followed by a second round of testing to validate iterative improvements made based on initial findings **(Play 1, 2, 4)**

### Epics & User Stories
All design and development tasks were directly executed using Agile methods to capture requirements and tasks.  These techniques included:
* **Epics** — created high-level user stories for specified main functions of keyword search user stories, architecture and provisioning, user experience and future enhancements 
* **User Stories** — scrum team collaborated to address user stories (Backlog Grooming) and prioritized functionality based on type and user needs
* **JIRA (Board)** — Product Manager used JIRA to manage user stories, assign tasks, identify and address bugs, create follow up, track resolution, and collect lightweight documentation
* **Task Assignment** — Product Manager collaborated with functional leads on allocation and self-selection of tasks (user research, persona creation, UX/UI flows, wireframes, visual design, front- and backend development, DevOps framework, QA, etc.)

### Development
To create the working prototype, our Agile development team followed our typical short-cycle, develop/test/deploy approach, collecting user feedback along the way.  We used modern, open-source development, testing, integration, and monitoring tools.  Our development processes included:
* **Environment** — deployed secure development, integration, and production environments in Amazon Web Services (AWS) IaaS cloud using Docker containers on EC2 virtual machines **(Play 9)**; we also deployed [Jenkins](http://54.174.243.195/) for continuous integration **(Play 10)**, [running automated tests](http://54.174.243.195/job/run-selenium-scripts-at-test/), and continuous deployment
* **Security** — deployed the environments into a VPC with a proven infrastructure, controlling access through security groups and a bastion host.  The application writes all auditable events to enable continuous monitoring **(Play 12)**
* **Development** — developed front-end and back-end code, using a fully open source toolset including  Linux, Docker, Apache HTTP, PHP, Laravel Framework, Python, Twitter Bootstrap, and many others **(Play 8)**.  We created documentation to install and run the prototype on another machine
* **QA** — conducted full-lifecycle testing, including unit testing using PHPUnit, automated functional testing using Selenium **(Play 10)**, and manual testing 
* **Versioning** — used GitHub source code management to streamline versioning, issue referencing, and revision control; we also used JIRA to track Agile sprints, issues, and change requests, tasks, etc, and linked JIRA to GitHub via DVCS connector **(Play 4)**

### Conclusion
The Aquilent project team used a thorough Agile approach to design and develop the full-stack prototype based on research yielding user needs and overall potential impact to citizens:
* **Usability Test #1** — Following Sprint 1, Aquilent conducted Usability Testing to guide future iterations.  This yielded several findings, particularly related to second drug search.  Based on these findings, we determined a need to:
  * Change link from Reaction list item in search results from drug interaction data to additional details about the Reaction reported
  * Add one or more additional search fields to the search functionality to make it easier to search for reactions to drug combinations
* **Sprint 2** — made terminology more consistent, updated drug brand names to valid trade names, made enhancements to mobile user experience including improved display of results to show in title case format, and improved button display  
* **Usability Test #2** — validated that updates made during Sprint #2 addressed usability issues.  
* **Planned Future Improvements** — determined user needs for pie chart views of reported outcomes, and pie chart views for reported adverse reactions to present the data that is clear and easy to interpret.  Usability Test #2 also yielded the next round of prototype enhancements including search result display, pagination, severity designation, labeling, and filtering.  

Overall, this exercise established a framework that could support the ongoing development and evolution of the Drug Reaction Finder.  Aquilent believes additional iterations would yield a viable tool that would help citizens make better informed health decisions.

### License
The Drug Reaction Finder prototype tool is free of charge **(Play 13)**, open-sourced software under the [MIT license](http://opensource.org/licenses/MIT).

Additional artifacts supporting our Agile process for this prototype can be found [in the repository](doc/). The running Drug Reaction Finder prototype tool will be available in AWS until August 21, 2015.

