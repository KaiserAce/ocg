<script lang="ts">
  import type { PageServerData } from "./$types";
  import SettingsForm from "./SettingsForm.svelte";
  import Calendar from "$lib/components/ui/calendar/calendar.svelte";
  import { Button } from "$lib/components/ui/button/index.js";
  import {
    CalendarDays,
    FileTextIcon,
    LayoutDashboardIcon,
    LogOutIcon,
    UserIcon,
    MenuIcon,
  } from "lucide-svelte";
  import {
    DateFormatter,
    getLocalTimeZone,
    today,
  } from "@internationalized/date";
  import * as Dialog from "$lib/components/ui/dialog";
  export let data: PageServerData;
  let counselors = data.counselor;
  let colleges = data.college;
  let appointments = data.appointments;
  let timeslots = data.timeslots;

  $: selectedDate = today(getLocalTimeZone());
  $: filterDate = "";
  $: filterAppointments = appointments;
  $: day = "";
  const df = new DateFormatter("en-US", {
    dateStyle: "long",
  });
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

<div
  class="mt-14 flex w-full flex-col justify-center gap-3 md:mt-10 lg:flex-row"
>
  <div class="box flex flex-col items-center gap-10">
    <div class="w-[290px] rounded bg-white p-2 shadow-xl">
      <Calendar
        minValue={today(getLocalTimeZone())}
        calendarLabel="Appointment Date"
        initialFocus
        onValueChange={(v) => {
          if (v) {
            selectedDate = v;
            filterDate = v.toString();
            filterAppointments = appointments.filter(
              (e) => e.Appointment_Date === filterDate,
            );
            day = [
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday",
            ][selectedDate.toDate(getLocalTimeZone()).getDay()];
          } else {
            console.log(v);
          }
        }}
      />
    </div>

    <Dialog.Root>
      <Dialog.Trigger>
        <Button size="long">
          <p class="text-lg">Book an Appointment</p>
        </Button>
      </Dialog.Trigger>
      <Dialog.Content class="max-h-96 overflow-y-scroll">
        <Dialog.Header>
          <Dialog.Title>Book an Appointment</Dialog.Title>
          <Dialog.Description
            ><p class="text-red-500">* Required Fields</p></Dialog.Description
          >
        </Dialog.Header>
        <SettingsForm data={data.form} {counselors} {colleges} {timeslots} />
      </Dialog.Content>
    </Dialog.Root>
  </div>

  <div class="box w-full rounded bg-white shadow-xl lg:ml-5 lg:w-1/3 lg:p-1">
    <h1 class="p-4 text-left text-xl lg:text-center">
      Counselor Schedules for<br />
      {df.format(selectedDate.toDate(getLocalTimeZone()))}
    </h1>
    <hr class="mx-4 h-3" />
    {#each counselors as counselor}
      {#each timeslots as email}
        {#if email.Email === counselor._id}
          <p class="pl-5">
            <b
              >{counselor.First_Name}
              {counselor.Middle_Name}
              {counselor.Last_Name}</b
            >
          </p>
          {#if day === "Monday"}
            {#each email.Monday as time}
              {#if filterAppointments.find((appointment) => appointment.Appointment_Time === time) && filterAppointments.find((appointment) => appointment.Counselor === counselor._id)}
                <p class="pl-10 text-sm">{time} - Unvailable</p>
              {:else}
                <p class="pl-10 text-sm">{time} - Available</p>
              {/if}
            {/each}
          {:else if day === "Tuesday"}
            {#each email.Tuesday as time}
              {#if filterAppointments.find((appointment) => appointment.Appointment_Time === time) && filterAppointments.find((appointment) => appointment.Counselor === counselor._id)}
                <p class="pl-10 text-sm">{time} - Unvailable</p>
              {:else}
                <p class="pl-10 text-sm">{time} - Available</p>
              {/if}
            {/each}
          {:else if day === "Wednesday"}
            {#each email.Wednesday as time}
              {#if filterAppointments.find((appointment) => appointment.Appointment_Time === time) && filterAppointments.find((appointment) => appointment.Counselor === counselor._id)}
                <p class="pl-10 text-sm">{time} - Unvailable</p>
              {:else}
                <p class="pl-10 text-sm">{time} - Available</p>
              {/if}
            {/each}
          {:else if day === "Thursday"}
            {#each email.Thursday as time}
              {#if filterAppointments.find((appointment) => appointment.Appointment_Time === time) && filterAppointments.find((appointment) => appointment.Counselor === counselor._id)}
                <p class="pl-10 text-sm">{time} - Unvailable</p>
              {:else}
                <p class="pl-10 text-sm">{time} - Available</p>
              {/if}
            {/each}
          {:else if day === "Friday"}
            {#each email.Friday as time}
              {#if filterAppointments.find((appointment) => appointment.Appointment_Time === time) && filterAppointments.find((appointment) => appointment.Counselor === counselor._id)}
                <p class="pl-10 text-sm">{time} - Unvailable</p>
              {:else}
                <p class="pl-10 text-sm">{time} - Available</p>
              {/if}
            {/each}
          {:else}
            <p></p>
          {/if}
          <p></p>
        {:else}
          <p></p>
        {/if}
      {/each}
    {/each}
  </div>
</div>
