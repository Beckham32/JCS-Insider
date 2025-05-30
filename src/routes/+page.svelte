<script lang="ts">
    import { onMount } from "svelte";
    import type { ScrapedData } from "./api/scraper/+server";

    let scrapedMenu: Promise<ScrapedData> | null = $state(null);
    onMount(async () => {
        fetch("/api/scraper");
        let scraperData = await fetch("/api/scraper");
        scrapedMenu = scraperData.json();
        console.log(await scrapedMenu);
    });
</script>

{#if !scrapedMenu}
    <div class="flex justify-center items-center min-h-screen w-full bg-[#191919] text-white">
        <h1 class="w-full text-3xl text-center font-bold">Loading Menu...</h1>
    </div>
{:else}
    <div class="min-h-screen w-full h-full flex flex-col text-black scroll" style="background: linear-gradient(to bottom, rgba(255,30,0,0.6), rgba(207,161,34,0.5));">
        <main class="flex flex-grow flex-col">
            <nav class="flex items-center justify-between bg-[#191919] text-white shadow-lg padding-[1rem, 1.5rem] mb-2 p-2">
                <div class="flex items-center gap-4">
                    <img src="https://joanecardinalschubert.cbe.ab.ca/images/802-logo.svg" alt="Logo" class="w-[5rem]">
                    <h1 class="text-[1.8rem] font-bold">JCS Insider</h1>
                </div>
                <!-- Dropdown -->
                <div class="flex items-center relative">
                    <button class="bg-transparent border-0 text-[40px] mr-[1rem] mb-[0.5rem] text-[#ff6565] transition-all duration-300 hover:text-[#ffc107] hover:cursor-pointer hover:block active:text-white" aria-label="Menu" aria-haspopup="true" aria-expanded="false">
                        <span class="">☰</span>
                    </button>
                    <ul class="hidden absolute bg-[#191919] min-w-[160px] shadow-lg px-[12px] py-[32px] z-1 top-3/4 -left-9 rounded-lg ">
                        <li class="text-white list-none w-full py-[0.5rem] pe-[0.5rem] hover:bg-[#928e8e] hover:cursor-pointer">Test 1</li>
                    </ul>
                </div>
            </nav>


            {#await scrapedMenu}
                <p class="text-center text-xl">Loading menu...</p>
            {:then data}
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 px-12 py-6">
                    {#each Object.entries(data) as [weekday, dayData]}
                        <div class="bg-white text-black rounded-xl p-5 shadow-xl">
                            <h2 class="text-2xl font-bold text-center border-b-2 border-black pb-2 mb-4">{weekday}</h2>
                            {#each Object.entries(dayData) as [categoryName, categoryData]}
                                <div class="mb-4">
                                    <h3 class="text-lg font-semibold text-red-700 text-[22px]">{categoryName}</h3>
                                    <ul class="space-y-1">
                                        <li class="flex justify-between text-sm border-b border-gray-300 py-1">
                                            <span class="font-bold overflow-auto w-full text-[16px]">{categoryData}</span>
                                        </li>
                                    </ul>
                                </div>
                            {/each}
                        </div>
                    {/each}
                </div>
            {:catch error}
                <p class="text-center text-red-200">{error.message}</p>
            {/await}  
        </main>
        <footer class="w-full flex items-center justify-center bg-gradient-to-r from-gray-950 to-gray-700 text-white min-h-30 py-12 shadow-lg">
            <h2 class="font-bold text-[18px]">&copy; Developed by the JCS Coding Club</h2>
        </footer>
    </div>
{/if}