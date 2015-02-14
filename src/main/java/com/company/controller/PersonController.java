package com.company.controller;

import com.company.model.Person;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
@SessionAttributes("personList")
public class PersonController {


    List<Person> personList = new ArrayList<Person>();


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "index";
    }

    @RequestMapping(value = "/person/add", method = RequestMethod.POST)
    public
    @ResponseBody
    List<Person> personAdd(@RequestBody Person request)
            throws Exception {

        Person person = new Person();

        person.setEmail(request.getEmail());
        person.setFirstname(request.getFirstname());
        person.setLastname(request.getLastname());

        personList.add(person);

        return personList;
    }


    @RequestMapping(value = "/person/list", method = RequestMethod.GET)
    public
    @ResponseBody
    List<Person> personList() {
        return personList;
    }


    @RequestMapping(value = "/person/delete/{id}", method = RequestMethod.GET)
    public
    @ResponseBody
    List<Person> personRemove(@PathVariable Integer id) {

        Person person = null;
        person = personList.get(id);

        personList.remove(person);

        return personList;
    }

    @RequestMapping(value = "/person/edit/{id}", method = RequestMethod.GET)
    public
    @ResponseBody
    List<Person> personEdit(@PathVariable Integer id) {

        Person person = null;
        person = personList.get(id);
        person.setId(String.valueOf(id));

        List<Person> prs = new ArrayList<Person>();
        prs.add(person);

        return prs;
    }


    @RequestMapping(value = "/person/update", method = RequestMethod.POST)
    public
    @ResponseBody
    List<Person> personUpdate(@RequestBody Person request)
            throws Exception {

        System.out.println("update...");

        Person person = null;
        person = personList.get(Integer.parseInt(request.getId()));
        personList.remove(person);

        person.setId(String.valueOf(request.getId()));
        person.setEmail(request.getEmail());
        person.setFirstname(request.getFirstname());
        person.setLastname(request.getLastname());

        personList.add(person);

        return personList;
    }

}