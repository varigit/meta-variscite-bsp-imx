# Conditionally add SkipVerify for demo
python do_prepare_mender_conf:append() {
    skip = d.getVar('VAR_MENDER_SERVER_SKIP_VERIFY', True)

    if not skip or skip.lower() not in ("1","true","yes"):
        return

    workdir_b = d.getVar("B")
    for name in ("transient_mender.conf", "persistent_mender.conf"):
        path = os.path.join(workdir_b, name)
        if not os.path.exists(path):
            continue

        with open(path, "r") as f:
            conf = json.load(f)

        if "SkipVerify" not in conf:
            conf["SkipVerify"] = True

            with open(path, "w") as f:
                json.dump(conf, f, indent=4, sort_keys=True)
}
