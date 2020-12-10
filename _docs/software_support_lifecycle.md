---
layout: post
title: Software Support Lifecycle
date: 2020-12-09
summary: Vox Pupuli policy on supporting upstream software
---

## Software Support Lifecycle

As a part of Vox Pupuli's mission to provide a home for modules that still have a userbase and need development, we need to define a clear support strategy for what operating systems, dependencies, and upstream software we will support and for how long those will be supported.

As we operate entirely on the graces of our community members being willing to voluntarily contribute to our modules, we also need to be respective of their time and resources and not add undue stress in order to support software that upstream creators no longer support.

To account for this, we no longer support any software or operating system after the date that the maintainers have marked said software or operating system as End of Life. However, this does not mean we will immediately remove code that allows for the module to run on End of Life'd software or operating systems, but the community will no longer be expected to provide support to users for that software.

There are exceptions and the full policy is detailed in the next section.

### Support Lifecycle

#### Operating Systems
An Operating System is no longer considered supported once it reaches an End of Life date determined by the upstream maintainer* of the operating system. To ensure our users have enough time to adjust, we will take the following steps to ensure as seamless of a transition as possible:

1. A deprecation PR will be created no later that 3 months before an Operating System's End of Life date.
2. Removal of the End of Life version from the metadata.json and tests to be completed by the End of Life date.
3. Issues relating to the End of Life operating system will no longer be addressed after the End of Life date.
4. Code allowing a module to be run on the End of Life operating system will be left in the module until one of the following milestones are reached after which time the code will be removed:
    1. Maintaining the code prevents the module from moving forward.
    2. 12 Months after the End of Life date.
5. Pull Requests will continue to be accepted with the following exceptions:
    1. Accepting such a pull request would be detrimental to the module's long term goals.
    2. The code has already been removed as per the standards set in section 4.

*maintainers include, but are not limited to, the community, company, or organization that maintains ownership over a specific piece of software or project.

##### Support Table:

| OS Name | Support Begins | End of Life | Notification PR | End of Support | Removal of Code |
| ------- | -------------- | ----------- | --------------- | -------------- | --------------- |
| CentOS/RHEL 6 | July 10th, 2011 | Nov 30th, 2020 | N/A | Nov 30th, 2020 | Nov 30th, 2021 |
| CentOS/RHEL 7 | July 7th, 2014 | June 30th, 2024 | Mar 31st, 2024 | June 30th, 2024 | June 30th, 2025 |
| CentOS/RHEL 8 | Sept 24th, 2019 | Dec 31, 2021 | Sept 30th, 2021 | Dec 31, 2021 | Dec 31, 2022 |
| CentOS Stream | Jan 1st, 2022 | N/A | N/A | N/A | N/A |
| Ubuntu 16.04 | Apr 21, 2016 | Apr 2021 | Jan 30th, 2021 | Apr 30th, 2021 | Apr 30th, 2022 |
| Ubuntu 18.04 | Apr 26th, 2018 | Apr 2023 | Jan 30th, 2023 | Apr 30th, 2023 | Apr 30th, 2024 |
| Ubuntu 20.04 | Apr 23rd, 2020 | Apr 2025 | Jan 30th, 2025 | Apr 30th, 2025 | Apr 30th, 2026 |
| Debian 9 | June 17th, 2017 | June 2022 | Mar 31st, 2022 | June 30th, 2022 | June 30th, 2023 |
| Debian 10 | July 6th, 2019 | 2024 | 2024 | 2024 | 2025 |
| Fedora 31 | Oct 29th, 2019 | Nov 24th, 2020 | N/A | Nov 24th, 2020 | Nov 24th, 2021 |
| Fedora 32 | Apr 28th, 2020 | May 2021 | Feb 2021 | May 31st, 2021 | May 31st, 2022 |
| Fedora 33 | Oct 27th, 2020 | Nov 2021 | Aug 2021 | Nov 30th, 2021 | Nov 30th, 2022 |
| OpenSUSE Leap 15.1 | May 22nd, 2019 | Jan 31st, 2021 | Dec 31st, 2020 | Jan 31st, 2021 | Jan 31st, 2022 |
| OpenSUSE Leap 15.2 | July 2nd, 2020 | Dec 31st, 2021 | Sept 30th, 2021 | Dec 31st, 2021 | Dec 31st, 2022 |

#### Puppet Versions

Puppet support will fall in-line with the Puppet Open Source project's lifecycle.

1. A Puppet version that has been labelled as End of Life by the Puppet Open Source project, will no longer be supported by Vox Pupuli.
2. A deprecation PR will be created no later than 6 months before End of Life.
3. All tests and data in metadata.json will be removed no later than the End of Life date for that version.
4. Code that works on the End of Life versions will not be removed unless it bars the progress of the module.
5. Pull Requests may still be accepted, as long as it doesn't hinder forward progress of the module or add End of Life-specific code.
6. Issues will no longer be accepted for the End of Life version.

#### Vox Pupuli Modules

Modules are considered supported only at their current latest release and roll forward, not back in case of any bugs or issues.

1. Modules are supported at their latest current version.
    1. Latest version is determined by the version number based on the following order:
        1. Major
        2. Minor
        3. Patch
        4. Examples: 
            1. `5.1.1` is the latest version and supported.
            2. `5.1.0` is not supported.
            3. `4.9.9` is not supported.
    2. Exceptions:
        1. The maintainer may make exceptions to the above rule as long as it does not create undue expectations for the community.
2. For all other documenation on Archived Modules see [Deprecated and Archived Modules]({% doc_url deprecated_and_archived_modules %})
