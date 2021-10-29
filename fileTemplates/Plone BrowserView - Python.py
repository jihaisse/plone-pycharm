# -*- coding: utf-8 -*-
# import logging

from Products.Five import BrowserView
from plone import api
from zope.interface import implements, Interface
from ${package_name} import _


# logger = logging.getLogger(__name__)


class I${class_name}View(Interface):
    """
    $class_name view interface
    """


class ${class_name}View(BrowserView):
    """
    $class_name browser view
    """
    implements(I${class_name}View)

    def __init__(self, context, request):
        self.context = context
        self.request = request
        
    @property
    def portal_catalog(self):
        return api.portal.get_tool('portal_catalog')