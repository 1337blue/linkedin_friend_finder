#!/usr/bin/env python3

"""
Creates a webhook for the given repo url.
Checks if a webhook with the given configuration exists before creating one.
"""

import argparse
import os

import lib


def entrypoint():
    """
    entrypoint function
    """

    args = parse_options()
    lib.find_friends(
        email=args.email,
        password=args.password,
        linkedin_person_url=args.linkedin_friend_url,
    )


def parse_options():
    """
    parse cli options
    """

    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )

    parser.add_argument(
        "--linkedin_friend_url",
        type=str,
        help="Full LinkedIn friend url (https://www.linkedin.com/in/boomadevi-madhanagopal-abb3b316/).",
        default=os.getenv("LI_FRIEND_URL"),
    )

    parser.add_argument(
        "--email",
        type=str,
        help="LinkedIn email",
        default=os.getenv("LI_EMAIL"),
    )

    parser.add_argument(
        "--password",
        type=str,
        help="LinkedIn password",
        default=os.getenv("LI_PASSWORD"),
    )

    return parser.parse_args()
