As a new TEE, AMD SEV AMD Secure Encrypted Virtualization (SEV) uses one key per virtual machine to isolate guests and the hypervisor from one another. The keys are managed by the AMD Secure Processor. SEV requires enablement in the guest operating system and hypervisor. The guest changes allow the VM to indicate which pages in memory should be encrypted. The hypervisor changes use hardware virtualization instructions and communication with the AMD Secure processor to manage the appropriate keys in the memory controller.

For this technology, there are three generations, SEV, SEV-ES, SEV-SNP. Find more information about SEV at this website. https://developer.amd.com/sev/

This project is to dump some SEV related information, e.g., hardware and software information. This can help to diagnose some issues which may caused by the platform settings.
