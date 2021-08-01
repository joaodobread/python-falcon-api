import functools


def Roles(*roles: str):
    """add roles to class. with roles can be blocked user without access"""
    def wrapper(original_class):
        orig_init = original_class.__init__

        @functools.wraps(original_class)
        def __init__(self, *args, **kws):
            self.falcon_security__roles = [*roles]
            self.falcon_security__unprotected = False
            orig_init(self, *args, **kws)

        original_class.__init__ = __init__
        return original_class
    return wrapper
