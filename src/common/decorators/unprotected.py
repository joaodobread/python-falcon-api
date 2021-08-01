import functools


def Unprotected():
    """add unprotected attribute to route"""
    def wrapper(original_class):
        orig_init = original_class.__init__

        @functools.wraps(original_class)
        def __init__(self, *args, **kws):
            self.falcon_security__roles = []
            self.falcon_security__unprotected = True
            orig_init(self, *args, **kws)

        original_class.__init__ = __init__
        return original_class
    return wrapper
