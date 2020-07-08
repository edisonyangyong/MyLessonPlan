//
//  InstructionModel.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/26/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

class InstructionModel{
    // MARK: Instruction Sequence Question Mark Notes
    var getIDfromTitle:[String:Int] = [
        "Advance Organizer":101,
        "Topics":102,
        "Check Understanding":103,
        "Direct Instruction":104,
        "I Do":105,
        "We Do":106,
        "You Do Together":107,
        "You Do Independent":108,
        "Present Information":109,
        "Organize Teams":110,
        "Assist Teams":111,
        "Assess Teams":112,
        "Provide Recognition":113,
        "Focus Discussion":114,
        "Hold Discussion":115,
        "End Discussion":116,
        "Debrief Discussion":117,
        "Engage":118,
        "Explore":119,
        "Explain":120,
        "Elaborate":121,
        "Evaluate":122,
        "My Language Objective":123,
        "Key Vocabulary":124,
        "Meaningful Activity":125,
        "State Objectives":126,
        "Differentiation":127,
        "Formative":128
    ]
    var getNoteFromID:[Int:[String]] = [
        101:[
            "What is an Advance Organizer?",
            "Advance Organizer is one or two sentences that inform students of something specific to pay attention to in the lesson (or video or presentation, etc.). It directs students’ attention forward into the upcoming lesson.",
            "Explanation / Example:",
            "The purpose of the Advance Organizer is to give the students an idea or question to think about during the lesson. Your Advance Organizer is the glue that connects your ideas together. You can refer back to it often. You can mention it many times throughout your presentation. This will help the students personalize the information you are teaching. It should help the students make meaning. Always start your lesson with an Advance Organizer. Advance Organizers are not limited to only Presentations. Every lesson you teach, every video you show, every picture, example, scenario you discuss should begin with an Advancer Organizer. Say something like, “Before we start today, I would like to give you an idea that might help you make meaningful connections between our lesson and your experiences. The idea is ….” “As we watch this video, I would like you to look for ways that ….” “As we discuss this topic today, ask yourself this question… How does this relate to ….” How could I apply this to …?” This part of a lesson is crucial for your students in order to intellectually and personally engage in the topic because it helps activate prior knowledge, background experiences, and makes the topic personal."],
        102:[
            "What are Topics?",
            "Topics are a way to organize your lesson in short chunks of information.",
            "Explanation / Example:",
            "In this part of your lesson plan, you begin teaching your lesson by using a structured format. i.e Topic 1, Topic 2, Topic 3. Remember that a Presentation / Lecture Instructional Model lesson needs to be structured so you will want your information grouped in to different TOPICS. A couple of things make the presentation model different than what we typically think of a lecture. First, use ‘signposts’ and ‘transitions.’ For example, “Now, this is the main idea of our discussion.” Or, “Let’s look at the next topic in our lesson.” Signposts and transitions are simple sentences to ‘mark’ transitions in the lesson, so include them in your lesson plan. Second, when we explain ‘concepts,’ we identify ‘critical’ and ‘noncritical’ characteristics. We also explain the concept using ‘examples,’ AND ‘nonexamples. Sometimes we learn what something is by understanding what it is NOT. Also, remember the Rule-Example-Rule format. Anytime you mention an idea or concept, give an example then restate the idea. Example: (Rule) The prices of items usually depends on the supply of the item. (Example) For example, if we have a shortage of oil, our gas prices will go up because more people will be willing to pay more for the gas. If we have a surplus of oil, our gas prices will go down because more gas is available to people. (Rule) So, you can see that the price of items, like gas, usually depends on the supply of the item. As with all teaching, use clear voice and go slow enough to accommodate all the learners. In addition, KNOW your content really well. The better you know the content, the more you can focus on student achievement instead of focusing on ‘covering’ all the material. You should write out the Presentation of New Information part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        103:[
            "What is Check For Understanding?",
            "Check For Understanding is the dedicated part of your lesson plan where you purposefully check if your students understand the content.",
            "Explanation / Example:",
            "As you teach a lesson, your main concern should be if the students understand what you are teaching. The only way you can know if the students understand what you are teaching is if you check. This is called ‘Check for Understanding.’ A teacher MUST check for understanding throughout the lesson, but especially before the Summative Assessment. Typically, the ‘Check for Understanding’ is done separately from the Summative Assessment of the lesson. In other words, the Check for Understanding part of your lesson plan is not the same thing as your Summative Assessment. You can check for understanding by asking meaningful HOTS (Higher Order Thinking Skills - i.e., Bloom's Taxonomy) questions. Ask questions that further develop the concepts and help students think past the obvious or easy answers. You could have them turn and talk to each other about the concepts and ideas, ask each other questions, etc. There are many ways to check for understanding before the Summative Assessment."],
        104:[
            "What is Direct Instruction?",
            "The Direct Instruction part of the Lesson Plan is the beginning of the instructional sequence where you verbally TELL your students the specific steps to master a skill. Be sure to have a poster with the steps visible for students.",
            "Explanation / Example:",
            "The direct instruction part of your lesson plan is where you explain 1) why the topic is important and 2) the steps or process the students use in achieving mastery. You explicitly explain your topic, why it is important, and then describe the steps or process the students take to complete the lesson. These steps should be written like:\nStep 1 --------\nStep 2 --------\nStep 3 --------\nEtc.\n\nAlso, these steps should be clearly and neatly written and posted so that the students can refer to them during the remainder of the lesson. Of course, this means your chart or poster should be big enough and clean enough to be readable.\n\nNOTE: The Direct Instruction Model is for teaching ‘skill mastery’ and ‘mastery of well-structured knowledge.’ The content of your lesson should be content you can accomplish following steps, not something interesting to explain, analyze, or show. This section of your lesson plan, Direct Instruction, is the same name as the instructional model. This section should not be lengthy, but should include all your examples.\nYou should write out the Direct Instruction part of your lesson plan using a lot of details. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        105:[
            "What is I Do?",
            "I Do is also called Teacher Modeling. This is the part of the lesson where teacher show / model / demonstrate exactly how the students will do the task. In other words, in the previous part of your lesson plan, you verbally explained (with the visual chart) how to do the task. Now, you show them how to do the task.",
            "Explanation / Example:",
            "Remember, the Teacher Modeling is EXACTLY the same as the Direct Instruction part. Do not VARY, ADJUST, SKIP any part of the steps when you are modeling the steps for your students.\n\nNOTE: This is not a group activity. Students should not be doing problems on the board, showing the other students how to do it, etc. This part is for the teacher to DEMONSTRATE for the students.\n\nYou should write out the Teacher Modeling part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        106:[
            "What is We Do?",
            "We Do is also called Guided Practice. This is the part of the lesson where the teacher show / model / demonstrate the task with help from the students. Teacher calls on students to provide answers, steps, demonstrations, etc. In other words, in the Teacher Modeling part of your lesson, you actually demonstrated to the students how to complete the skill following the steps. Now, in the Guided Practice part of the lesson you include the students to complete the steps.",
            "Explanation / Example:",
            "In the We Do portion of the lesson, the teacher is still in control of the content. The teacher can call on students to volunteer help as the teacher works through an example following the steps provided to master the skill. Remember, the Guided Practice is EXACTLY the same as the Teacher Modeling. Do not VARY, ADJUST, or SKIP any part of the STEPS as students help you show, model, or demonstrate. You may have to clarify any misconceptions as students volunteer comments and you notice some of the students were not understanding the I Do (Teacher Modeling) part of the lesson. You should write out the Guided Practice part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        107:[
            "What is You Do Together?",
            "This is the part of your lesson where your students will be completing the task TOGETHER without your help as much as possible. ",
            "Explanation / Example",
            "This is an important step because you allow the students to work together without your direct help. Of course, you should circulate but only to guide and help those groups or pairs who seem stuck.\n\nConsider the progression so far in this instructional sequence. In the Direct Instruction part of your lesson, you verbally explained (with visual charts, etc.) how to complete the skill. In the I Do (Teacher Modeling) part of your lesson, you actually demonstrated to the students how to complete the skill following the steps. In the We Do (Guided Practice) part of the lesson the students volunteered help as you completed the skill following the steps. Now, in the You Do Together, students worked together to complete the steps as you circulate, helping out where needed.\n\nRemember, the You Do Together is EXACTLY the same as the Guided Practice and Teacher Modeling. Do not VARY, ADJUST, or SKIP any part of the STEPS when the students are working together to accomplish the task / skill. You should write out the You Do Together part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        108:[
            "What is You Do Independently?",
            "This part is also called Independent Practice. This is the part of your lesson where your students will be independently completing the task.",
            "Explanation / Example:",
            "Consider the progression so far through this instructional sequence. In the Direct Instruction part of your lesson, you verbally explained (with visual charts, etc.) how to complete the skill. In the I Do (Teacher Modeling) part of your lesson, you actually demonstrated to the students how to complete the skill following the steps. In the We Do (Guided Practice) part of the lesson the students volunteered help as you completed the skill following the steps. In the You Do Together, students worked together to complete the steps as you circulated around, helping out where needed. Now, in the You Do (Independent Practice) the students work individually on completing the task. The teacher should circulate, but should not help the students as much as in the Guided Practice. Students should be working on their own. In this part of the lesson, students should be able to complete the skill on their own to show you they are ready for the Summative Assessment.\n\nRemember, the You Do (Independent Practice) is EXACTLY the same as the Guided Practice and Teacher Modeling. Do not VARY, ADJUST, or SKIP any part of the STEPS when the students are doing the task independently. You should write out the Independent Practice part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give.Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        109:[
            "What is Present Information?",
            "This is the part of the cooperative learning lesson plan where you explain 1) why the topic is important, 2) the background knowledge from other lessons important to succeed in this activity, 3) /inform the learners what they will be doing - the INSTRUCTIONS for the group work, 4) Prepare the students for teamwork. ",
            "Explanation / Example:",
            "Your instructions for doing the task should be clearly and neatly written and posted so that the students can refer to them during the remainder of the lesson. Of course, this means your chart or poster should be big enough and clean enough to be readable from anywhere in the classroom.\n\nRemember that the Cooperative Learning model is for teaching student achievement in content areas and also for developing collaboration skills and increasing students’ acceptance of diversity. The content of your lesson should be content that students can master by working together.\n\nYou should write out the Present Information part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        110:[
            "What is Organize Into Learning Teams? ",
            "This is the part of your lesson where you decide how the learning teams are formed, which students work with each other, where in the classroom each group will work, what roles/responsibilities each student has, etc. This might be the most important part of this instructional model. This part is certainly where most problems can occur if not planned carefully. ",
            "Explanation / Example:",
            "During this part of the lesson, teacher should tell students their groups, where the groups should meet, and the roles for each group member. Remember, the teacher decides this information, not the students. Teacher tells students what group they are in: This means you have thought this out considering all possibilities and the dynamics of the students. How will you group the students? Mix of ethnic diversity? Mix of boys / girls? Mix of academic ability? Are there behavior issues? All these questions need to be carefully considered. Remember the goal is achievement in the content, but also increase acceptance of diversity, and building collaboration skills. You should explain your ideas and decision making process in your lesson plan.\n\nWhere the groups should meet: This means that before class you decide where the groups will meet. In which location of the classroom will they gather? What is their team name? Maybe you could have a picture on the wall in the corner where you want each team, i.e., a Lion in one corner, a Horse in another corner, a Shark in another corner. Then under the students’ chairs, tape a picture matching the group they will be in. This makes choosing groups more fun for the students and allows the teacher the choice of which students go in which group together.\n\nThe roles of each group member: This means that teacher decides which of the students will do what job. For example, a student can be the ‘SCRIBE’ and take notes or do the writing. One student could be the ‘TIMEKEEPER’ and watch the clock making sure the group is working at a good pace. Look online for many more examples of roles in Cooperative Learning groups. All of the above are decided beforehand and told to the students BEFORE they split into groups (in the Present Information part of the lesson plan).\n\nYou should write out the Organize Learning Teams part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        111:[
            "What is the Assist Learning Teams?",
            "This part of the lesson is where the students work together in completing the project / task. While they are working, teacher is circulating among the students explaining, clarifying, and helping as needed.",
            "Explanation / Example:",
            "During this part of the lesson, the students are in their groups working together. The teacher is circulating among the student groups explaining, clarifying, and helping as needed. The trick for the teacher is determining when to give students information and how much information to give the students. The goal for students is to learn content, so the teacher should not be readily available to simply transmit answers to students. Students should work together to learn. You may have to explain the instructions again to some groups, and that is ok. Remember, the students are working together, so talking is normal and encouraged.\n\nYou should write out the Assist Learning Teams part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        112:[
            "What is the Assess Learning Teams?",
            "This is the part of the lesson where the teacher measures what the students learned individually and as a group. ",
            "Explanation / Example:",
            "After the students have worked together to accomplish the project / task, you should assess them individually and as a group. If you give a quiz, one idea is to give each student an individual score and then average the group’s quiz scores and give the group another score. If the group presents a project / poster, you can assess students based on their individual contributions, as well as give an overall group score. Remember that the goal is student achievement. Students can achieve without being given a traditional test. Other assessment options are recommended, such as posters, speeches, role plays, participation, journals, graphic organizers, notes during the group work, etc. You should explain your ideas and decision making process in your lesson plan.\n\nYou should write out the Assess Learning Teams part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        113:[
            "What is Provide Recognition?",
            "This is the part of your lesson where students are rewarded or recognized. You can use certificates of achievement, letters home to parents, names on the bulletin board.",
            "Explanation / Example:",
            "After the groups have worked on their project and completed the learning activities, the teacher should recognize their accomplishment. The students can present their project to the class, show off their work, etc. This can be done through a group presentation or a gallery walk type of activity. You should explain your ideas and decision making process in your lesson plan.\n\nYou should write out the Provide Recognition part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        114:[
            "What is Focus Discussion?",
            "This is the part of the lesson when you focus the topic of the discussion. You could ask a thought provoking question, read a short anecdote, raise an issue, present a puzzling situation, etc. all to bring clarity and focus to the topic of the discussion.",
            "Explanation / Example:",
            "An effective discussion is clear and to the point and is centered on one focused topic. A group of people sitting around talking about a topic is NOT a discussion. A discussion is “a mutual endeavor by a group of people to develop, refine, or contextualize an idea or set of ideas.” (See Lemov, D. 2015. Teach Like a Champion 2.0: 62 Techniques that put students on the path to college. San Francisco, CA Jossey-Bass. Page 315. We highly recommend this book). A discussion focuses on an in-depth understanding of a topic and provides for sustained exchanges between students in a respectful manner. Two big benefits of discussions is that they help teachers ‘observe’ students’ thinking, and proper discussions promote higher order / critical thinking skills.\n\nIn this Focus the Discussion part of the discussion you must explain the purposes of the discussion. This is where you pose a specific question, raise an appropriate issue, or present a puzzling situation associated with the topic. Essential questions are though provoking and intellectually challenging. A guiding question is also a good way to focus the discussion.\n\nYou should write out the Focus the Discussion part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        115:[
            "What is Hold the Discussion?",
            "Hold the Discussion part of your lesson is where most of the talking takes place. ",
            "Explanation / Example:",
            "The teacher must be keep the discussion from wandering. A number of great techniques can help to facilitate a good discussion. Random calling is when you draw popsicle sticks with names on them to speak. Or, implement some way to randomly calling on students instead of waiting for students to raise their hands.\n\nHere are some must do’s during the Hold the Discussion:\nYou must keep a record of comments. Use the whiteboard and write down notes as the students talk. You only need enough detail here to help you remember what the comment was about. This will do a couple of things. It will provide the students with reminders of what other students have already said, and it will help you after the discussion summarize the key ideas talked about.\n\nWait Time is critical. Wait time is the amount of time from when the teacher asks a question until calling on a student. The longer the wait time, the more thoughtful student responses will be.\n\nUse Sentence Starters. These are short phrases to help students begin their comment. These sentence starters will force the students to connect their ideas to the previous person’s ideas and help the discussion flow well. These sentence starters also help students to clarify their thinking. “I agree, but have you considered…” “I understand why you’d say that, but…” “I was just thinking of something similar, that…” “I want to build on what _________ said…”\n\nQuestions are critical. You must thoughtfully script out the questions you plan to ask. These not only include your focus and essential questions, but also questions to help the discussion continue. Your questions determine how deeply the students think. If you want a thoughtful, intellectually stimulating discussion, script out thoughtful, intellectually stimulating questions. Do NOT ‘wing it’ or think you can come up with questions on the spot.\n\nScript what questions you will ask.\nList down some anticipated responses.\nWrite how you will respond (validate + extend)\nAll of this should be written in your lesson plan. Don’t forget you are keeping a record of everyone’s comments. Refer back to them often. You should write out the Hold the Discussion part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        116:[
            "What is End the Discussion?",
            "This is the part where you bring the discussion to a close. ",
            "Explanation / Example:",
            "You want to leave enough time. You should 1) summarize in a few sentences what has been said, 2) tie various ideas together or relate them to the larger topic being studied, 3) use a short presentation highlighting new or previously studied information, 4) give the students a 3x5 card and ask them to write the most important or main idea they got from the discussion.\n\nYou should write out the End the Discussion part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your students may give. Writing out this level of detail will 1) help you think through your lesson carefully, 2) require you to clarify in your own mind what you are saying and doing, and 3) practice and visualize yourself teaching."],
        117:[
            "What is Debrief the Discussion?",
            "Debrief the Discussion is when you talk about the discussion itself and how the students felt about the discussion. Did the students respect each other? What were the positive things about the discussion? What were the negative things about the discussion, etc.",
            "Explanation / Example:",
            "Debrief the Discussion is NOT a summary of the ideas discussed. It is NOT asking the students what they learned. The idea for debriefing the discussion is to help students think about their thinking. You must teach the students the difference between the discussion of ideas and the debriefing of the discussion.\n\nPose and talk about questions (for example):\n1. How do you think the discussion went today?\n2. Did we give everyone a fair chance to speak?\n3. Did we listen to one another’s ideas?/n4. Were there times during the discussion where we got off topic?\n5. What can we do next time to make our discussion more stimulating or engaging?\n\nYou should write out the Debrief the Discussion part of your lesson plan using a lot of detail. In fact, write EVERYTHING you plan to say, all the questions you plan to ask, all the directions you plan to give, and all the responses you anticipate your "],
        118:[
            "What is Engage?",
            "The Engage is the first part of the lesson where the teacher creates interest for the upcoming lesson. This is like an Anticipatory Set to generate curiosity, introduce the concept or skill.",
            "Explanation / Example:",
            "This phase of the lesson is to quickly mentally engage students and capture their interest. A good idea is to design an activity where students can describe what they know about the topic, concept, or skill being developed. The teacher should elicit student responses that uncover what the students already know or think about the concept. It is important for the teacher to include opportunities for the students to make connections between what they already know and the new content. The student should ask questions, such as ‘Why did this happen? What do I already know about this? What have I found out about this?"],
        119:[
            "What is Explore?",
            "The Explore part of the lesson is time for students to explore the problems or content presented without direct instruction or help from the teacher (as much as possible).",
            "Explanation / Example:",
            "The teacher should encourage the students to work together. The teacher should observe and listen to students as they interact, ask probing questions to redirect the students’ investigation when necessary, and give the students time to puzzle through problems.  The students explore through hands on activities. Students should grapple with the problem or phenomenon and describe it in their own words. The students should test predictions and hypotheses, try alternatives, record observations and ideas, discuss connections/conclusions with group. The main goal for this phase of the lesson is to provide students with shared experiences or help students acquire a common set of experiences that they can use to help each other make sense of the new concept or skill."],
        120:[
            "What is Explain?",
            "At this point in the lesson, after engaging and exploring, students should explain what they know about the concept.",
            "Explanation / Example:",
            "After the students have explored the content on their own, the students should develop explanations about the content. The explanation follows the experience. The teacher encourages the students to explain concepts and definitions in their own words. The teacher should ask for evidence and clarification from students. After the students explain the content the best they can using their own words, the teacher formally provides the definitions, explanations, and new labels. The students should explain the content, possible solutions, observations to others and listen to others’ explanations. This is done ‘officially.’ In other words, students should write what they hear with interpretations, evidence provided. The students listen and try to comprehend explanations the teacher provides. The students should use recorded observations in their explanations."],
        121:[
            "Whait is Elaborate?",
            "Elaborate is where the students apply what they learn to new situations to develop a deeper understanding of the concept or a greater use of the skill.",
            "Explanation / Example:",
            "During this phase of the lesson, the teacher expects students to use formal labels, definitions, and explanations provided in the previous phase of the lesson as students apply or extend the concepts and skills to new situations. The teacher should remind students of alternative explanations. The teacher should refer students to the existing data and evidence and asks, ‘what do you already know? Why do you think…? The students apply the new labels, definitions, explanations, and skills in new, but similar situations. The students use previous information to ask questions, propose solutions, make decisions, and design experiments. The students should be able to draw reasonable conclusions from the evidence and record observations and explanations. Here the students should also check for understanding among their peers. It is important for students to discuss and compare their ideas with each other during this phase."],
        122:[
            "What is Evaluate?",
            "The Evaluate is the final phase of the lesson to provide students opportunities to review and reflect on their own learning and new understanding and skills.",
            "Explanation / Example:",
            "During this final phase of the lesson, the students should review and reflect on their own learning. At this time, the students should provide evidence for changes to their understandings, beliefs, and skills in the topic. The teacher observes the students as they apply new concepts and skills to assess the students’ knowledge and skills. The teacher should look for evidence that the students have changed their thinking or behaviors. It is appropriate to allow the students to assess their own learning and group-process skills. The teacher should ask open-ended questions, such as, Why do you think…? What evidence do you have? What do you know about… topic? How would you explain…? The students should ask questions, such as, Why did this happen? What do I already know about this? What have I found out about this? Of course, by this phase of the lesson, the students should show an interest in the topic."],
        123:[
            "What is Language Objective",
            "Coming soon",
            "Explanation / Example:",
            "Coming soon"],
        124:[
            "What is Key Vocabulary",
            "Coming soon",
            "Explanation / Example:",
            "Coming soon"],
        125:[
            "What is Meaningful Activity",
            "Coming soon",
            "Explanation / Example:",
            "Coming soon"],
        126:[
            "What is ‘State the Objectives?’",
            "In this part of your lesson, you verbally tell your students the Learning Objectives. Verbally tell the students and display the learning objectives on a chart or whiteboard, and include them on the graphic organizer.",
            "Explanation / Example:",
            "In this part of your lesson plan, you simply  tell (verbally) the students the objectives for the lesson in language they can understand. Use simple English appropriate for the grade and proficiency level of your students. In other words, many times you will not state your objectives using the same words in which you wrote them earlier in your lesson plan. Remember, the objective gives your students an expectation and a reason for sitting in class today. You must also have these Learning Objectives clearly and neatly written on a poster or on the whiteboard so that you and the students can refer to them as needed. NOTE: writing the Learning Objectives on the board at the time you are stating them is NOT appropriate and wastes time, so don’t do it. Have your Learning Objectives written before the lesson starts. A good way to accomplish this important step in your lesson is to write the Learning Objectives on the graphic organizer you give to the students."],
        127:[
            "What is Differentiation?",
            "Explain WHAT, HOW, and WHY you are using differentiation in the Presentation Instructional Sequence. Explain the differentiation in terms of the three key UDL principles, and the Content, Process, Product, Environment information we have studied",
            "",
            ""],
        128:[
            "What is Formative Assessment",
            "Explain WHAT, HOW, and WHY you are using Formative Assessment",
            "",
            ""],
    ]
    
    var popupTitleOnRoadMap = "Welcome to the Help Popup!"
    var popupContentOnRoadMap = "Use this road map to navigate directly to sections of your lesson plan."
    
    var popupTitleOnWhat = "What is Instruction Sequence?"
    var popupContentOnWhat = "Presentation/Lecture:\nThis instructional model is perfect when the content is new information or if the content will build on existing information. This model can be combined with student centered models like Cooperative Learning or Classroom Discussion. In other words, use the Presentation/Lecture model to present content and then use the Cooperative Learning model or Classroom Discussion model to help the students make meaning and further deepen their learning. Remember that the headings are critical for student achievement. Present the content in logical topics, using effective differentiation for maximum student learning.\n\nDirect Instruction:\nThis instructional model is perfect for scaffolding instruction and providing a step by step model to master a skill, well-structured knowledge, and skill mastery. Each of these headings is necessary for the success of the instructional model as each heading plays a different role in the students’ achievement of the skill. The principle of ‘gradual release of intellectual responsibility’ is the overriding factor in this instructional model. Of course, this model goes well with Cooperative Learning. For example, the heading ‘You Do Together’ would be an appropriate time to incorporate a Cooperative Learning segment to the lesson.\n\nCooperative Learning:\nThis instructional model is designed to facilitate group work in a purposeful way. This model is more than simply putting students in groups working together. Specific goals should be accomplish among which are to accomplish an academic task, increase tolerance for diversity, and develop collaboration skills among students. Following these headings is critical to the success of an effective Cooperative Learning lesson and student achievement.\n\nClassroom Discussion:\nThis instructional model is designed to facilitate sustained, in-depth, respectful dialogue about a given topic. The goals for an effective discussion should be to focus on in-depth understanding, allowing students to contextualize their ideas, provide personal interpretations of content AND defend their interpretations. Each of the headings in this model play a significant role in the overall success of the classroom discussion and student achievement.\n\n5Es (Science):\n(Instructional model designed to teach Science concepts or other content in an inquiry format. This model is a framework to help students progress through the content in engaging, meaningful activities. Each of the phases of this instructional model are necessary to student achievement and deep learning. (See: http://nextgenerationscience.weebly.com/5-es-of-science-instruction.html also see: http://stimulatingsciencesimulations.blogspot.com/2012/09/5-e-posters.html)."
    
    var popupTitleNextToPercentage = "My Lesson Plan Required Information"
    var popupContentNextToPercentage = "This is an explanation of this percentage"
    
    var practiceDict = [
        "Lesson Preparation":[
            "Content objectives should be clearly defined, displayed, and reviewed with students.",
            "Language Objectives should be clearly defined, displayed, and reviewed with students.",
            "Ensure content concepts appropriate for age and educational background.",
            "Supplementary materials must be used to a high degree.",
            "Adapt the content to all levels of student proficiency.",
            "Include meaningful activities that integrate lesson concepts with language practice opportunities."],
        "Building Background":[
            "Be sure that the concepts are explicitly linked to students’ background experiences.",
            "Links must be explicitly made between past learning and the new concepts.",
            "Key vocabulary taught, used, and emphasized!"],
        "Comprehensible Input":[
            "Teacher speech appropriate for students’ proficiency level.",
            "Academic tasks must be clearly explained and modeled for students.",
            "A variety of techniques should be used to make content concepts clear."],
        "Strategies":[
            "Give students ample opportunities to use learning strategies.",
            "Scaffolding techniques consistently used, to assist and support student understanding.",
            "Deliberately use a variety of questions or tasks that promote Higher-Order Thinking Skills (HOTS)."],
        "Interaction":[
            "Frequent opportunities provided for interaction and discussion.",
            "Grouping configurations (seating, group work) must support language and content objectives of the lesson.",
            "Don’t forget to consistently provide sufficient wait time for student responses.",
            "Give students ample opportunity to clarify key concepts in their L1 (First Language)."],
        "Practice & Application":[
            "Provide hands-on materials and / or manipulatives for students to practice using new content knowledge.",
            "Design activities for students to apply content and language knowledge.",
            "Design activities that integrate all language skills (reading, writing, listening, speaking)."],
        "Lesson Delivery":[
            "Purposefully ensure that content objectives are clearly supported by lesson delivery.",
            "Purposefully ensure that language objectives are clearly supported by lesson delivery.",
            "Students should be meaningfully engaged approximately 90% to 100% of the class period.",
            "Remember pacing of the lesson must be appropriate to students’ ability levels."],
        "Review & Assessment":[
            "Comprehensive review of key vocabulary during the lesson.",
            "Comprehensive review of key content concepts during the lesson.",
            "Give regular feedback to students on their language output.",
            "Make sure the assessment measures Student Comprehension and Learning of all Learning Objectives."],
    ]
}
