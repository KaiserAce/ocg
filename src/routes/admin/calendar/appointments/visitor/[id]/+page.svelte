<script lang="ts">
  import {
    CalendarDays,
    FileTextIcon,
    LayoutDashboardIcon,
    UserIcon,
    LogOutIcon,
    MenuIcon,
  } from "lucide-svelte";
  import type { PageServerData } from "./$types";
  import * as Card from "$lib/components/ui/card";
  import { Textarea } from "$lib/components/ui/textarea";
  import { Button } from "$lib/components/ui/button";
  export let data: PageServerData;
  let appointment = data.appointments;
  let counselor = data.counselors;
  let counselorName = "";
  if (counselor != null) {
    counselorName = `${counselor.First_Name} ${counselor.Middle_Name} ${counselor.Last_Name}`;
  }
</script>

<head>
  <style>
    header {
      display: flex;
      font-family: Urbanist, sans-serif;
      background-color: #8e1537;
      color: white;
      padding-bottom: 20px;
    }
  </style>
</head>

<div class="threedots absolute right-4 md:right-10">
  <button
    id="dropdownMenuIconButton"
    data-dropdown-toggle="dropdownDots"
    class="rounded-2xl bg-white p-3 text-center text-sm font-medium text-gray-900 hover:bg-gray-300 dark:bg-gray-800 dark:text-white dark:hover:bg-gray-700 dark:focus:ring-gray-600"
    type="button"
  >
    <MenuIcon size={25} />
  </button>

  <div
    id="dropdownDots"
    class="menu z-10 hidden divide-y divide-gray-100 rounded-lg bg-white shadow dark:divide-gray-600 dark:bg-gray-700"
  >
    <ul
      class="py-2 text-sm text-gray-700 dark:text-gray-200"
      aria-labelledby="dropdownMenuIconButton"
    >
      <li>
        <a
          href="/admin/dashboard"
          class="flex items-center px-5 py-2 text-base text-black hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
        >
          <LayoutDashboardIcon size={15} />
          <p class="ml-3">Dashboard</p>
        </a>
      </li>
      <li>
        <a
          href="/admin/records"
          class="flex items-center px-5 py-2 text-base text-black hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
        >
          <FileTextIcon size={15} />
          <p class="ml-3">Records</p>
        </a>
      </li>
      <li>
        <a
          href="/admin/calendar"
          class="flex items-center px-5 py-2 text-base text-black hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
        >
          <CalendarDays size={15} />
          <p class="ml-3">Calendar</p>
        </a>
      </li>
      <li>
        <a
          href="/admin/profiles"
          class="flex items-center px-5 py-2 text-base text-black hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
        >
          <UserIcon size={15} />
          <p class="ml-3">Accounts</p>
        </a>
      </li>
    </ul>
    <div class="py-2">
      <a
        href="/api/logout"
        class="flex items-center px-5 py-2 text-base text-sm text-gray-900 hover:bg-gray-100 dark:text-gray-200 dark:hover:bg-gray-600 dark:hover:text-white"
      >
        <LogOutIcon size={15} />
        <p class="ml-3">Log Out</p>
      </a>
    </div>
  </div>
  <script src="https://unpkg.com/flowbite@1.5.1/dist/flowbite.js"></script>
</div>

<h1 class="pb-4 pt-12 font-bold sm:pt-5">Visitor Appointment</h1>

<div>
  <Card.Root>
    <Card.Header>
      <Card.Title>Appointment Details</Card.Title>
    </Card.Header>
    <Card.Content>
      <div class="space-y-1">
        <div class="flex">
          <Card.Title>Visitor Name:</Card.Title>
          <p class="leading-5" style="padding-left: 63px;">
            {appointment.Visitor_Name}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Visitor Email:</Card.Title>
          <p class="leading-5" style="padding-left: 67px;">
            {appointment.Visitor_Email}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Contact Number:</Card.Title>
          <p class="leading-5" style="padding-left: 34px;">
            {appointment.Contact_Num}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Affiliated Institution:</Card.Title>
          <p class="leading-5" style="padding-left: 13px;">
            {appointment.Visitor_Institution}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Counselor:</Card.Title>
          <p class="leading-5" style="padding-left: 84px;">
            {counselorName}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Appointment Date:</Card.Title>
          <p class="leading-5" style="padding-left: 15px;">
            {appointment.Appointment_Date}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Appointment Time:</Card.Title>
          <p class="leading-5" style="padding-left: 15px;">
            {appointment.Appointment_Time}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Nature of Concern:</Card.Title>
          <p class="leading-5" style="padding-left: 19px;">
            {appointment.Nature_Of_Concern}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Status:</Card.Title>
          <p class="leading-5" style="padding-left: 108px;">
            {appointment.Status}
          </p>
        </div>
        <div class="flex">
          <Card.Title>Denial Remark:</Card.Title>
          <p class="leading-5" style="padding-left: 45px;">
            {appointment.Denial_Remark}
          </p>
        </div>
        <Card.Title>Session Remarks:</Card.Title>
        <form method="POST" action="?/remark">
          <div class="py-1">
            <Textarea
              placeholder="Type your remarks here."
              name="session_remarks"
              bind:value={appointment.Session_Remarks}
            />
          </div>
          <div class="py-2">
            <Button type="submit">Add Remarks</Button>
          </div>
        </form>
      </div>
    </Card.Content>
  </Card.Root>
</div>
