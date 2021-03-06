package edu.sjsu.conference.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.sjsu.conference.domain.AwsService;
import edu.sjsu.conference.domain.Conference;
import edu.sjsu.conference.repository.ConferenceRepository;

@Controller
@RequestMapping("/NewConference")
public class ConferenceController {
	@Autowired
	private ConferenceRepository repository;
	//private User user;
	private JobDetail job;

	private AwsService awsService;

	protected static Logger log = Logger.getLogger("ConferenceController");

	@RequestMapping(method = RequestMethod.GET)
	public String setupRegistration(
			@ModelAttribute("conference") Conference conference,
			BindingResult result) {
		return "NewConference";
	}

	/*
	 * @RequestMapping(method=RequestMethod.GET) public ModelAndView
	 * getConference() { ModelAndView mv = new ModelAndView("NewConference");
	 * mv.addObject("user", user); return mv; }
	 */

	@RequestMapping(method = RequestMethod.POST)
	public String Conference(
			@ModelAttribute("conference") @Valid Conference conference,
			BindingResult result, ModelMap model) {
		try {
			log.debug("registerConference() : conference = "
					+ conference.toString());

			// Set participants emails' from the text in html
			String[] participantArray = conference.getParticipants().split(",");
			conference.setInvitedParticipantsList(Arrays
					.asList(participantArray));
			List<String> attendees = new ArrayList<String>();
			conference.setAttendees(attendees);
			conference.setDropbox_link("");
			System.out.println("attendees are: " + conference.getAttendees());

			for (int i = 0; i < participantArray.length; i++) {
				InternetAddress addr = new InternetAddress(participantArray[i]);
				addr.validate();
			}

			// Insert into the collection conference, if collection not present
			// then create it
			repository.addConference(conference);
			// Send emails to the participants using AWS SNS [START]
			SendInvitationWithSNS(participantArray, conference.getId(),
					conference.getTopic());
			// Send emails to the participants using AWS SNS [END]
			// Display all the documents from the collection
			List<Conference> part = repository.listConference();
			for (int i = 0; i < part.size(); i++) {
				log.debug("All Conference details:" + part.get(i));
			}
		} catch (AddressException e) {
			// e.printStackTrace();
			return "redirect:/NewConference";
		}
		return "redirect:/UserHome";
	}

	public void SendInvitationWithSNS(String[] emailList, int aId, String aTopic) {
		// String[] emailListToBeDelated;//delete this line for the demo
		// FIXME
		// TODO: Remove hardcoded email id lists. For testing purpose, give your
		// email id.
		// String emailIds =
		// "ramya.machina@gmail.com,machina_ramya@yahoo.com,ramya.machina@sjsu.edu";//delete
		// this line for the demo
		// emailListToBeDelated = emailIds.split(",");//delete this line for the
		// demo
		AWSSNS sns = awsService.create();

		// Schedular for every 60 secs [START]

		try {

			System.out.println("Job = " + job);

			if (job == null) {

				job = new JobDetail();
				job.setName("publishJob");
				job.setJobClass(AWSSNS.class);

				CronTrigger trigger = new CronTrigger();
				trigger.setName("TriggerName");
				trigger.setCronExpression("0/60 * * * * ?");

				// schedule it
				Scheduler scheduler = new StdSchedulerFactory().getScheduler();
				scheduler.start();
				scheduler.scheduleJob(job, trigger);
			} else
				System.out.println("Schedular is running...");

		} catch (Exception e) {
			e.printStackTrace();
		}
		// Schedular for every 60 secs [END]

		if (sns != null) {
			sns.addSubscribers(emailList, aId, aTopic);// replace
														// emailListToBeDelated
														// with emailList for
														// the demo.

		}
	}
}
