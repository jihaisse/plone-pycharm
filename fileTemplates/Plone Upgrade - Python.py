import logging
from Products.CMFCore.utils import getToolByName
from App.Common import package_home
import os

PROFILE_ID = 'profile-${package_name}:default'
PRODUCTS_PATH = os.sep.join(package_home(globals()).split(os.sep))
osp = os.path


def upgrade(upgrade_product, version):
    """ Decorator for updating the QuickInstaller of a upgrade """

    def wrap_func(fn):
        def wrap_func_args(context, *args):
            p = getToolByName(context, 'portal_quickinstaller').get(upgrade_product)
            setattr(p, 'installedversion', version)
            return fn(context, *args)

        return wrap_func_args

    return wrap_func