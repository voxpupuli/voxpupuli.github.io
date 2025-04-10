---
layout: page
title: Voluntary Product Accessibility Template
subsection: openvox
---

The Voluntary Product Accessibility Template (VPAT) is a document that describes how an information technology (IT) product, such as software, hardware, or web-based applications, meets the accessibility standards defined by Section 508 of the US Rehabilitation Act.
This VPAT describes the accessibility features of the OpenVox open-source project.

* Product Name: OpenVox
* Version: (all versions)

## Evaluation Methods Used

This VPAT is based on a review of the OpenVox tool and project documentation, including the project website and the software documentation.
It also references upstream documentation from the [puppet.com](https://www.puppet.com/docs/puppet/latest) website.

### Section 1194.21 - Software Applications and Operating Systems

OpenVox is a command-line utility for configuring, automating, and managing computer infrastructure.
It is designed as a server-agent model, driven by a plain-text codebase.
This means that once installed and configured, most users' interactions will be via writing or editing code in their text editor of choice.
Users with accessibility needs may configure their editors with the assistive technologies they rely on.

Administering, configuring, or using the software generally involves editing files on the filesystem and executing commands.
Like other command-line tools, this software can be used with screen readers and other assistive technologies to access the command-line interface to perform these operations.
The OpenVox software interface itself is not optimized for use with assistive technologies.
Users with accessibility needs may configure their command line terminal and editors with the assistive technologies they rely on.

### Section 1194.22 - Web-based Intranet and Internet Information and Applications

OpenVox does not have any web-based features, so this section does not apply.

### Section 1194.23 - Telecommunications Products

OpenVox does not include any telecommunications features, so this section does not apply.

### Section 1194.24 - Video and Multimedia Products

OpenVox does not include any video or multimedia features, so this section does not apply.

### Section 1194.25 - Self-Contained, Closed Products

OpenVox is an open-source command-line utility and does not meet the requirements of this section.

### Section 1194.26 - Desktop and Portable Computers

OpenVox is a command-line utility and does not include a graphical user interface (GUI or TUI) that could be used with assistive technologies. This section does not apply.

### Section 1194.31 - Functional Performance Criteria

OpenVox does not include any functional performance criteria.

### Section 1194.41 - Information, Documentation, and Support

The OpenVox project provides built-in documentation in the form of Unix man pages and help function output.
This documentation is accessible using screen readers and other assistive technologies.
The Vox Pupuli project publishes online documentation in HTML format, which is accessible using screen readers and other assistive technologies.
The documentation includes installation instructions, tutorials, best-practice guides, and other resources.
However, this documentation is not designed with accessibility needs in mind and may be difficult to read with some screen readers and other assistive technologies.
The project does not offer any support services for users with disabilities.

As the OpenVox project is a fork of the formerly open source Puppet project, users often also refer to the upstream Puppet documentation.
This upstream documentation includes installation and configurations instructions, conceptual guides, language references, and other resources.
However, this upstream documentation is not designed with accessibility needs in mind and relies on Javascript in the browser for basic functionality.
This may make it difficult to read or navigate with some screen readers and other assistive technologies.

Like most technical documentation, OpenVox and Puppet documentation may be technical and difficult for non-technical users to understand.

## Conclusion

OpenVox is an open-source command-line utility that provides basic accessibility features for users who rely on assistive technologies.
However, the software is not optimized for use with assistive technologies and may require significant customization to be accessible to all users.
Users with accessibility needs may configure their command line terminal and editors with the assistive technologies they rely on.
The project provides accessible online documentation, but may not be suitable for non-technical users.
